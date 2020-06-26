////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2019-11-11
// MODIFIED: 2020-06-26
// PURPOSE: main js file for app
// DEPENDENCIES: NA
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

import "./scss/index.scss"

////////////////////////////////////////

// menu toggle
const menu = document.getElementById("menuToggle");
const sidebar = document.getElementById("sidebar");
const sidebarBtns = document.querySelectorAll(".sidebar .menu button, .sidebar .menu a");

// toggle sidebar state
function toggle_sidebar () {
    if ([...sidebar.classList].indexOf("sidebar-revealed") > -1) {
        sidebar.classList.remove("sidebar-revealed");
        sidebar.setAttribute("aria-hidden", "true");
        menu.setAttribute("aria-expanded", "false");
    } else {
        sidebar.classList.add("sidebar-revealed");
        sidebar.removeAttribute("aria-hidden");
        menu.setAttribute("aria-expanded", "true");
    }
}

// bind menu toggle to sidebar buttons
sidebarBtns.forEach(btn => btn.addEventListener("click", toggle_sidebar));

// menu toggle click
menu.addEventListener("click", (event) => {
    toggle_sidebar();
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

// input binding for accordion
// const accordionToggle = new Shiny.inputBinding();
const accordionToggle = new Shiny.InputBinding();
$.extend(accordionToggle, {
    find: function(scope) {
        return $(scope).find(".accordion-button");
    },
    getValue: function(el) {
        return null;
    },
    setValue: function(el) {
        return null;
    },
    subscribe: function(el, callback) {
        $(el).on("change.accordionToggle", function(e) {
            var id = $(el).attr("data-group");
            $(`section.accordion-section[data-group='${id}']`)[0].classList.toggle("browsertools-hidden");
        });
    },
    unsubscribe: function(el) {
        $(el).off(".accordionToggle");
    }
});

// register
Shiny.inputBindings.register(accordionToggle);

// cue trigger
$(document).on("click", "button.accordion-button", function(e) {
    var el = $(e.target);
    el.trigger("change");
})