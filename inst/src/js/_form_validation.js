////////////////////////////////////////////////////////////////////////////////
// FILE: _form_validation.js
// AUTHOR: David Ruvolo
// CREATED: 2020-07-09
// MODIFIED: 2020-07-09
// PURPOSE: Form Validation for Sign in page
// DEPENDENCIES: NA
// STATUS: in.progress
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////


// Reset Form
// Define a function that clears form inputs and resets invalid input elements
// @param elem the ID of the form to reset
function reset_form(elem) {

    // find form
    const form = document.getElementById(elem);

    // reset inputs
    const inputs = form.querySelectorAll("input[aria-invalid='true']");
    if (inputs.length) {
        inputs.forEach(el => el.removeAttribute("aria-invalid"));
    }

    // clear error messages
    const errors = form.querySelectorAll(".error-text");
    if (errors.length) {
        errors.forEach(el => el.innerText = "");
    }
}

// showError
// Define a function that shows an input element and error message
// @param elem an ID of the input to make invalid
// @param error an error message to display
function show_error(elem, error) {

    // find input and add invalid attribute
    const input = document.getElementById(elem);
    input.setAttribute("aria-invalid", "true");

    // extract error element ID and insert text
    const errorID = input.getAttribute("aria-describedby");
    const errorElem = document.getElementById(errorID);
    errorElem.innerText = error;

    // set listener for blur and not empty
    input.addEventListener("keypress", function _keyup(e) {
        if (e.target.value.length > 3) {
            input.removeAttribute("aria-invalid");
            errorElem.innerText = "";
            input.removeEventListener("keypress", _keyup, true);
        }
    }, true);

}

// export
module.exports = {
    reset_form: reset_form,
    show_error: show_error
}
