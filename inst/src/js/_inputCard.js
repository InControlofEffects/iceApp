////////////////////////////////////////////////////////////////////////////////
// FILE: _inputCard.js
// AUTHOR: David Ruvolo
// CREATED: 2020-07-20
// MODIFIED: 2020-07-20
// PURPOSE: input binding for accordion component with input as title
// DEPENDENCIES: NA
// STATUS: in.progress
// COMMENTS: Input binding for Accordion Component where the title is is also
// a checkbox input. Convert the checked status to binary to eliminate steps
// in the R server.
////////////////////////////////////////////////////////////////////////////////

// create new input binding
var InputCard = new Shiny.InputBinding();

// define behavior
$.extend(InputCard, {
    find: function(scope) {
        return $(scope).find(".card.input-card");
    },
    initialize: function(el) {
        return $(el).find("input[type='checkbox']").is(":checked");
    },
    getValue: function(el) {
        return $(el).find("input[type='checkbox']").is(":checked");
    },
    subscribe: function(el, callback) {

        // onClick event for <button>: if open, ....
        $(el).on("click","button.card-toggle", function(e) {
            var btn = $(this);
            if (btn.hasClass("rotated")) {
                $(el).find(".card-content").css("display", "none");
                btn.attr("aria-expanded", "false");
                btn.removeClass("rotated");
            } else {
                $(el).find(".card-content").css("display", "block");
                btn.attr("aria-expanded", "true");
                btn.addClass("rotated");
            }
        });
        
        // onClick event for checkbox input
        $(el).on("change", "input[type='checkbox']", function() {
            $(el).toggleClass("selected");
            callback();
        });

    },

    // when `reset_card_input` is run, reset card state
    receiveMessage: function(el) {
        var btn = $(el).find("button.card-toggle");
        $(el).removeClass("selected");
        if (btn.hasClass("rotated")) {
            btn.removeClass("rotated");
            btn.attr("aria-expanded", "false");
            $(el).find(".card-content").css("display", "none");
            $(el).find("input[type='checkbox']").prop("checked", false);
        }
        this.getValue();
    },
    unsubscribe: function(el) {
        $(el).off("InputCard");
    }
});


export default InputCard;