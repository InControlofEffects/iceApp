////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-11
// MODIFIED: 2020-07-07
// PURPOSE: main js file for app
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////


// import scss
import "./scss/index.scss"

////////////////////////////////////////

// sign in form handlers
import { reset_form, show_error } from "./js/_form_validation"

// reset form
Shiny.addCustomMessageHandler("reset_form", function(data) {
    reset_form(data.elem);
});

// show Error
Shiny.addCustomMessageHandler("show_error", function(data) {
    show_error(data.elem, data.error);
});

////////////////////////////////////////



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
        updateProgressBar(data.elem, data.now, data.max);
    }, 200)
});


////////////////////////////////////////

// handler that updates the document title
Shiny.addCustomMessageHandler("set_document_title", function(data) {
    document.title = data.title;
});

////////////////////////////////////////

// register
import Accordion from "./js/_accordion"
Shiny.inputBindings.register(Accordion);


////////////////////////////////////////

// handler that processes page fade
Shiny.addCustomMessageHandler("fadePage", function(data) {
    let p = document.querySelector(".page");
    p.classList.add("fadeOut");
    p.classList.remove("fadeIn");
})