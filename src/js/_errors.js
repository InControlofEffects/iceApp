////////////////////////////////////////////////////////////////////////////////
// FILE: _errors.js
// AUTHOR: David Ruvolo
// CREATED: 2020-07-21
// MODIFIED: 2020-07-22
// PURPOSE: methods for showing and hiding error messages
// DEPENDENCIES: NA
// STATUS: in.progress
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////


// update_error_box
// Show and set the inner text of an error box
// @param id ID of the element
// @param error message to display
function update_error_box(id, error) {
    const elem = document.getElementById(id);
    const text = elem.getElementsByTagName("span")[0];
    elem.style.display = "flex";
    text.innerText = error;
}


// reset_error_box
// Hide and clear error box
// @param id id of the error box
function reset_error_box(id) {
    const elem = document.getElementById(id);
    const text = elem.getElementsByTagName("span")[0];
    elem.style.display = "none";
    text.innerText = "";
}


// update_error_text
// Show and hide an error text element
// @param id id of the error element
// @param error message to display
function update_error_text(id, error) {
    const elem = document.getElementById(id);
    elem.style.display = "flex";
    elem.innerText = error;
}


// reset_error_text
// Hide and reset an error text element
// @param id id of the error element
function reset_error_text(id) {
    const elem = document.getElementById(id);
    elem.style.display = "none";
    elem.innerText = "";
}


// export
module.exports = {
    update_error_box: update_error_box,
    update_error_text: update_error_text,
    reset_error_box: reset_error_box,
    reset_error_text: reset_error_text
}





