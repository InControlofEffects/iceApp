////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-11
// MODIFIED: 2020-01-27
// PURPOSE: main js file for app
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

// define custom handlers -- other handlers are now bundled in the shinytools pkg
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