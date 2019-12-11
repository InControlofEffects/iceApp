////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-11
// MODIFIED: 2019-11-21
// PURPOSE: main js file for app
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// DEFINE SHINY HANDLERS
(function () {
    
    // ADD CSS CLASS
    function addCSS(elem, css) {
        document.querySelector(elem).classList.add(css);
    }

    // CLEAR INPUTS
    function clearInputs(elems){
        const inputs = document.querySelectorAll(elems);
        inputs.forEach( input => input.value = "");
    }

    // LOG SOMETHING TO THE CONSOLE
    function consoleLog(value, asDir) {
        if (asDir) {
            console.dir(value);
        } else {
            console.log(value);
        }
    }

    // REMOVE CSS CLASS
    function removeCSS(elem, css) {
        document.querySelector(elem).classList.remove(css);
    }

    // TOGGLE CSS CLASS
    function toggleCSS(elem, css) {
        document.querySelector(elem).classList.toggle(css);
    }

    // SET INNERHTML
    function innerHTML(elem, string, delay) {
        if(delay){
            setTimeout(function(){
                document.querySelector(elem).innerHTML = string;
            }, delay)
        } else {
            document.querySelector(elem).innerHTML = string;
        }
    }

    // SET ELEMENT ATTRIBUTES
    function setElementAttribute(elem, attr, value) {
        document.querySelector(elem).setAttribute(attr, value);
    }

    // REFRESH PAGE
    function refreshPage() {
        history.go(0);
    }

    // SCROLL TO TOP OF PAGE
    function scrollToTop(){
        window.scrollTo(0,0);
    }

    // SHOW ELEM (SHOW / HIDE)
    function showElem(id) {
        const el = document.getElementById(id);
        el.classList.remove("hidden");
        el.removeAttribute("hidden");
    }

    // HIDE ELEM
    function hideElem(id){
        const el = document.getElementById(id);
        el.classList.add("hidden");
        el.setAttribute("hidden", true);
    }

    ////////////////////////////////////////
    // register modals
    Shiny.addCustomMessageHandler("addCSS", function (value) {
        addCSS(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("clearInputs", function(value){
        clearInputs(value)
    })

    Shiny.addCustomMessageHandler("consoleLog", function (value) {
        consoleLog(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("innerHTML", function (value) {
        innerHTML(value[0], value[1], value[2])
    });

    Shiny.addCustomMessageHandler("refreshPage", function (event) {
        refreshPage();
    });

    Shiny.addCustomMessageHandler("removeCSS", function (value) {
        removeCSS(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("setElementAttribute", function (value) {
        setElementAttribute(value[0], value[1], value[2]);
    });

    Shiny.addCustomMessageHandler("toggleCSS", function (value) {
        toggleCSS(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("hideElem", function (value) {
        hideElem(value[0], value[1]);
    });
    
    Shiny.addCustomMessageHandler("showElem", function (value) {
        showElem(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("scrollToTop", function(value){
        scrollToTop();
    })
})();


////////////////////////////////////////////////////////////////////////////////

// ADDITIONAL FUNCTIONS
const utils = (function(){

    // reset side effects
    const resetSideEffects = function() {
        
        // get elements
        var cards = document.querySelectorAll(".side-effect-cards .card");
        var definitions = document.querySelectorAll(".card-content");
        var toggles = document.querySelectorAll(".card-toggle");

        // cards: remove any focus states and selected classes from cards
        cards.forEach(function (card) {
            card.classList.remove("focused");
            card.classList.remove("selected");
        });

        // content: collapse definitions
        definitions.forEach(function (def) {
            def.classList.remove("expanded")
            def.setAttribute("hidden", "");
        });

        // reset toggles: remove rotated and update aria-attributes
        toggles.forEach(function (toggle) {
            toggle.classList.remove("rotated");
            toggle.setAttribute("aria-expanded", false);
        });
    }

    // toggle definitions
    const toggleDefinitions = function(){
    
        // get toggles
        var toggles = document.querySelectorAll(".card-toggle");
        
        // add event listener
        toggles.forEach(function(toggle){
    
            // init counter
            var index = 0;
    
            // add listener
            toggle.addEventListener("click", function(){
                
                // get elements
                var content = this.parentNode.querySelector(".card-content");
    
                // toggle button rotated class + expand content
                this.classList.toggle("rotated");
                content.classList.toggle("expanded");
    
                // update attributes
                if(index === 0){
                    this.setAttribute("aria-expanded", true);
                    content.removeAttribute("hidden");
                    index = 1;
                } else {
                    this.setAttribute("aria-expanded", false);
                    content.setAttribute("hidden", "");
                    index = 0;
                }
                
            })
        })
    }

    // toggleSelection - i.e., custom focus events
    const toggleSelection = function(){

        // get elements
        var cards = document.querySelectorAll(".card");
        var inputs = document.querySelectorAll(".checkboxes");
        var lastInputIndex = inputs.length - 1;
        var lastInput = inputs[lastInputIndex];
    
        // add event listeners
        inputs.forEach(function(input){
            
            // on focus
            input.addEventListener("focus", function(){
                cards.forEach(function(card){ card.classList.remove("focused"); })
                this.parentNode.parentNode.classList.add("focused");
            });
    
            // on input
            input.addEventListener("input", function(){
                this.parentNode.parentNode.classList.toggle("selected");
            });
    
        });
    
        // add additional listener for last link
        lastInput.addEventListener("blur", function(){
            this.parentNode.parentNode.classList.remove("focused");
        })
    }


    ////////////////////////////////////////
    // update progress bar

    const updateProgressBar = function(value){

        // find element elements
        var direction = value[0];
        var maxpages = value[1];
        var currentPage = value[2];
        var pb = document.getElementById("bar");
        var refElem = document.querySelector("body");
        var width = refElem.getBoundingClientRect().width;
        var percentComplete = Math.round((currentPage / maxpages) * 100);
        var rate = width / maxpages;
        var percent = rate / width;
        var currentPercent;

        // handle previous page
        if (direction === -1) {
            currentPercent = percent * currentPage;
            pb.style.transform = "scaleX(" + currentPercent +")";
            pb.setAttribute("aria-valuenow", percentComplete);
            pb.setAttribute("aria-valuetext", "On page " + currentPage + " of " + maxpages + "; " + percentComplete + "% complete");
        } else if (direction === 1) {
            currentPercent = percent * currentPage;
            pb.style.transform = "scaleX(" + currentPercent +")";
            pb.setAttribute("aria-valuenow", percentComplete);
            pb.setAttribute("aria-valuetext", "On page " + currentPage + " of " + maxpages + "; " + percentComplete + "% complete");
        } else if (direction === 0) {
            currentPercent = percent;
            pb.style.transform = "scaleX(" + currentPercent +")";
            pb.setAttribute("aria-valuenow", percentComplete);
            pb.setAttribute("aria-valuetext", "On page " + currentPage + " of " + maxpages + "; " + percentComplete + "% complete");
        } else {
            console.error("ERROR in function 'updateProgressBar', direction is not valid");
        }

        // update document title
        document.title = "In Control of Effects" +  " | Page " + currentPage;

    }

    return {
        resetSideEffects : resetSideEffects,
        toggleDefinitions : toggleDefinitions,
        toggleSelection : toggleSelection,
        updateProgressBar : updateProgressBar,
    }

})();

// resetSideEffects
Shiny.addCustomMessageHandler("resetSideEffects", function (event) {
    utils.resetSideEffects();
});


// updateProgressBar
Shiny.addCustomMessageHandler("updateProgressBar", function (value) {
    setTimeout(function(){
        utils.updateProgressBar(value);
    }, 50)
});