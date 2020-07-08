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

import "./scss/index.scss"

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

// input binding for accordion
const accordionToggle = new Shiny.InputBinding();
$.extend(accordionToggle, {
    find: function(scope) {
        return $(scope).find(".accordion-button");
    },
    initialize: function(el) {
        return null;
    },
    getValue: function(el) {
        return null;
    },
    subscribe: function(el) {
        $(el).on("click", function(e) {
            var btn = $(this);
            var id = btn.attr("data-group");
            var section = $(document).find(`section.accordion-section[data-group='${id}']`);
            if (section.hasClass("browsertools-hidden")) {
                section.removeClass("browsertools-hidden");
                section.removeAttr("aria-hidden");
                btn.attr("aria-expanded", "true");
            } else {
                section.addClass("browsertools-hidden");
                section.attr("aria-hidden", "true");
                btn.attr("aria-expanded", "false")
            }
        });
    },
    unsubscribe: function(el) {
        $(el).off(".accordionToggle");
    }
});

// register
Shiny.inputBindings.register(accordionToggle);


////////////////////////////////////////

// handler that processes page fade
Shiny.addCustomMessageHandler("fadePage", function(data) {
    let p = document.querySelector(".page");
    p.classList.add("fadeOut");
    p.classList.remove("fadeIn");
})