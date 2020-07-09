////////////////////////////////////////////////////////////////////////////////
// FILE: _accordion.js
// AUTHOR: David Ruvolo
// CREATED: 2020-07-09
// MODIFIED: 2020-07-09
// PURPOSE: custom input binding for handling accordion toggles
// DEPENDENCIES: Shiny
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

var Accordion = new Shiny.InputBinding();
$.extend(Accordion, {
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
        $(el).off(".Accordion");
        $(el).off("click");
    }
});

export default Accordion