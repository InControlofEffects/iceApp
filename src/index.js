////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-11
// MODIFIED: 2020-03-24
// PURPOSE: main js file for app
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

import "./css/index.scss"


// toggle definition
function toggle_definition(id) {

    // get elements
    let section = document.querySelector(`.card-content[data-group='${id}']`);
    let btn = document.querySelector(`button[data-group='${id}'`);
    let open = btn.getAttribute("aria-expanded") === true;
    
    // modify attributes and classes
    btn.classList.toggle("rotated");
    btn.setAttribute("aria-expanded", !open);

    section.classList.toggle("expanded");
    section.setAttribute("aria-hidden", !open);
}

// bind
Shiny.addCustomMessageHandler("toggle_definition", function(data) {
    toggle_definition(data.id);
});


////////////////////////////////////////

// set selection
function toggle_selection(id) {
    let card = document.querySelector(`.card[data-group='${id}']`);
    card.classList.toggle("selected");
}

// bind
Shiny.addCustomMessageHandler("toggle_selection", function(data) {
    toggle_selection(data.id);
})


// reset side effects
function reset_side_effects() {

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

// resetSideEffects
Shiny.addCustomMessageHandler("reset_side_effects", function (value) {
    reset_side_effects(value);
});

////////////////////////////////////////
// update progress bar
function updateProgressBar(value) {

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
        pb.style.transform = "scaleX(" + currentPercent + ")";
        pb.setAttribute("aria-valuenow", percentComplete);
        pb.setAttribute("aria-valuetext", "On page " + currentPage + " of " + maxpages + "; " + percentComplete + "% complete");
    } else if (direction === 1) {
        currentPercent = percent * currentPage;
        pb.style.transform = "scaleX(" + currentPercent + ")";
        pb.setAttribute("aria-valuenow", percentComplete);
        pb.setAttribute("aria-valuetext", "On page " + currentPage + " of " + maxpages + "; " + percentComplete + "% complete");
    } else if (direction === 0) {
        currentPercent = percent;
        pb.style.transform = "scaleX(" + currentPercent + ")";
        pb.setAttribute("aria-valuenow", percentComplete);
        pb.setAttribute("aria-valuetext", "On page " + currentPage + " of " + maxpages + "; " + percentComplete + "% complete");
    } else {
        console.error("ERROR in function 'updateProgressBar', direction is not valid");
    }

    // update document title
    document.title = "In Control of Effects" + " | Page " + currentPage;
}

// updateProgressBar
Shiny.addCustomMessageHandler("updateProgressBar", function (value) {
    setTimeout(function () {
        updateProgressBar(value);
    }, 150)
});