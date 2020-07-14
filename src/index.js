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

// import js
import { reset_form, show_error } from "./js/_form_validation"
import { updateProgressBar } from "./js/_progress"
import Accordion from "./js/_accordion"
import { reset_side_effects } from "./js/_reset_side_effects"

////////////////////////////////////////

// DOMContentLoaded event: execute only once
window.addEventListener("DOMContentLoaded", function(e) {

    // update html attributes
    const html = document.getElementsByTagName("html")[0];
    html.lang = "en";
    html.dir = "ltr";

}, {once: true})

////////////////////////////////////////

// bind shiny events

// reset form
Shiny.addCustomMessageHandler("reset_form", function(data) {
    reset_form(data.elem);
});

// show Error
Shiny.addCustomMessageHandler("show_error", function(data) {
    show_error(data.elem, data.error);
});

// progress bar
Shiny.addCustomMessageHandler("updateProgressBar", function (data) {
    setTimeout(function () {
        updateProgressBar(data.elem, data.now, data.max);
    }, 200)
});

// handler that processes page fade
Shiny.addCustomMessageHandler("fadePage", function(data) {
    let p = document.querySelector(".page");
    p.classList.add("fadeOut");
    p.classList.remove("fadeIn");
})

// resetSideEffects
Shiny.addCustomMessageHandler("reset_side_effects", function (value) {
    reset_side_effects(value);
});

// handler that updates the document title
Shiny.addCustomMessageHandler("set_document_title", function(data) {
    document.title = data.title;
});

// register
Shiny.inputBindings.register(Accordion);

