////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-11
// MODIFIED: 2020-07-22
// PURPOSE: main js file for app
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

// import scss
import "./scss/index.scss"

// import js
import { reset_login_form, show_login_error } from "./js/_login"
import update_progress_bar from "./js/_progress"
import { update_error_box, reset_error_box, reset_error_text, update_error_text } from "./js/_errors"

////////////////////////////////////////

// DOMContentLoaded event: execute only once
window.addEventListener("DOMContentLoaded", function (e) {

    // update html attributes
    const html = document.getElementsByTagName("html")[0];
    html.lang = "en";
    html.dir = "ltr";

}, { once: true });

////////////////////////////////////////

// bind: reset_login_form
Shiny.addCustomMessageHandler("reset_login_form", function (data) {
    reset_login_form(data.elem);
});

// bind: show_login_error
Shiny.addCustomMessageHandler("show_login_error", function (data) {
    show_login_error(data.elem, data.error);
});

// bind: update_error_box
Shiny.addCustomMessageHandler("update_error_box", function (data) {
    update_error_box(data.id, data.error);
});

// bind: reset_error_box
Shiny.addCustomMessageHandler("reset_error_box", function (data) {
    reset_error_box(data.id);
});


// bind: update_error_text
Shiny.addCustomMessageHandler("update_error_text", function (data) {
    update_error_text(data.id, data.error);
});

// bind: reset_error_text
Shiny.addCustomMessageHandler("reset_error_text", function (data) {
    reset_error_text(data.id);
});


// bind: update_progress_bar
Shiny.addCustomMessageHandler("update_progress_bar", function (data) {
    setTimeout(function () {
        update_progress_bar(data.elem, data.now, data.max);
    }, 200)
});

// bind: fade_page
Shiny.addCustomMessageHandler("fade_page", function (data) {
    let p = document.querySelector(".page");
    p.classList.add("fadeOut");
    p.classList.remove("fadeIn");
});


////////////////////////////////////////

// prevent submit on login form inputs
function prevent__input__submit() {
    const inputs = document.querySelectorAll("input.login__input");
    inputs.forEach((el) => {
        el.addEventListener("keydown", (e) => {
            switch(e.key) {
                case "Enter":
                    e.preventDefault();
                    break;
            }
        });
    });
}

$(document).on("shiny:connected", function (e) {
    setTimeout(function () {
        prevent__input__submit();
    }, 500)
});
