////////////////////////////////////////////////////////////////////////////////
// FILE: _reset_side_effects.js
// AUTHOR: David Ruvolo
// CREATED: 2020-07-09
// MODIFIED: 2020-07-09
// PURPOSE: reset side effects methods
// DEPENDENCIES: NA
// STATUS: in.progress
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// BEGIN

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

// export
module.exports = {
    reset_side_effects: reset_side_effects,
}