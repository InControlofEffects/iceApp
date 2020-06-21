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

import "./scss/index.scss"


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
Shiny.addCustomMessageHandler("select_effect", function(data) {
    document.querySelector(`.card[data-group=${data.id}]`).classList.add("selected");
});

Shiny.addCustomMessageHandler("deselect_effect", function(data) {
    document.querySelector(`.card[data-group=${data.id}]`).classList.remove("selected");
});


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

function progress_data(el, now, max) {
    const elem = document.getElementById(el);
    const container = elem.parentElement;
    const width = container.getBoundingClientRect().width;
    const bins = width / max;
    const rate = bins / width
    const transform_value = rate * now;
    return {
        width: width,
        rate: rate,
        transform_value: transform_value
    }
}


// update progress bar
// @param el unique ID of progress bar element
// @param now current page number
// @param max max page numbers
function updateProgressBar(el, now, max) {
    const elem = document.getElementById(el);
    const d = progress_data(el, now, max);
    elem.style.transform = `scaleX(${d.transform_value})`;
    elem.style.transformOrigin = `${d.rate} center`
}

// updateProgressBar
Shiny.addCustomMessageHandler("updateProgressBar", function (data) {
    setTimeout(function () {
        updateProgressBar(data.el, data.now, data.max);
    }, 200)
});