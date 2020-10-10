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

// bind: fade_page
Shiny.addCustomMessageHandler("fade_page", function (data) {
    let p = document.querySelector(".page");
    p.classList.add("fadeOut");
    p.classList.remove("fadeIn");
});
