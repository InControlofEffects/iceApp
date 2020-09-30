////////////////////////////////////////////////////////////////////////////////
// FILE: _progress.js
// AUTHOR: David Ruvolo
// CREATED: 2020-07-09
// MODIFIED: 2020-08-03
// PURPOSE: methods for updating progress bar
// DEPENDENCIES: Shiny
// STATUS: working
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////

function progress_data(el, now, max) {
    const elem = document.getElementById(el);
    const container = elem.parentElement;
    const width = container.getBoundingClientRect().width;
    const bins = width / max;
    const rate = bins / width;
    const transform_value = rate * now;
    return {
        width: width,
        rate: rate.toFixed(2),
        transform_value: transform_value
    }
}


// update progress bar
// @param el unique ID of progress bar element
// @param now current page number
// @param max max page numbers
function update_progress_bar(el, now, max) {
    const elem = document.getElementById(el);
    const bar = elem.querySelector(".progressbar__bar");
    const d = progress_data(el, now, max);
    bar.style.transform = `scaleX(${d.transform_value})`;
    bar.style.transformOrigin = `${d.rate} center`
    elem.setAttribute("aria-valuenow", now);
    elem.setAttribute("aria-valuetext", `page ${now} of ${max}`);
}


// export
export default update_progress_bar
