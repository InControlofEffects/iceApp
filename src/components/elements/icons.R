#'//////////////////////////////////////////////////////////////////////////////
#' FILE: icons.R
#' AUTHOR: David Ruvolo
#' CREATED: 2019-09-05
#' MODIFIED: 2019-09-05
#' PURPOSE: single source for all svg icons
#' PACKAGES: NA
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////

# define parent element
icons <- list()


# CHECKMARK
icons$checkmark <- '<svg aria-hidden="true" class="icon icon-checkmark" width="50px" height="50px" viewBox="0 0 50 50" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><title>checkmark</title><desc>checkmark</desc><path d="M11,28.9300656 C14.3797715,36.7182524 17.8819129,38.8692323 21.506424,35.3830052 C25.1309352,31.8967781 31.9621272,24.4357763 42,13" id="Line" stroke="currentColor" fill="none" stroke-width="5" transform="translate(26.500000, 25.000000) rotate(-0.462322) translate(-26.500000, -25.000000) "></path></svg>'


#'////////////////////////////////////////
# SUB LIST FOR CHEVRONS
icons$chevron <- list()

# CHEVRON LEFT
icons$chevron$left <- '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" class="icon icon-chevron-left" width="50px" height="50px" viewBox="0 0 50 50" aria-hidden="true"><title>left facing chevron</title><g id="icon-chevron-left-filled"><path id="Rectangle" fill="currentColor" transform="translate(24.657056, 26.521100) scale(-1, 1) rotate(-90.000000) translate(-24.657056, -26.521100) " stroke="currentColor" d="M9.13602134,19.8640447 L40.1781563,19.8640447 C40.730441,19.8640447 41.1781563,20.3117599 41.1781563,20.8640447 C41.1781563,21.1797513 41.0290717,21.4769179 40.7759964,21.66566 L25.7980655,32.8361132 C25.7704937,32.8566761 25.7418794,32.8758027 25.7123367,32.8934169 C25.5723927,32.9768553 25.4477534,33.0360265 25.3384188,33.0709303 C25.216665,33.1097987 25.0294175,33.1455407 24.7766762,33.1781563 C24.5274992,33.1446863 24.3411966,33.1089443 24.2177686,33.0709303 C24.1108512,33.0380013 23.9812479,32.9818503 23.8289587,32.9024773 L23.8289589,32.902477 C23.7834415,32.8787534 23.7398183,32.8515605 23.6984759,32.8211394 L8.5433489,21.6694883 C8.09851469,21.3421643 8.00325379,20.7162065 8.33057774,20.2713723 C8.51903062,20.0152642 8.81804995,19.8640447 9.13602134,19.8640447 Z"/></g></svg>'

# chevron right
icons$chevron$right <- '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" class="icon icon-chevron-right" width="50px" height="50px" viewBox="0 0 50 50" aria-hidden="true"><title>right facing chevron</title><g id="icon-chevron-right-filled"><path d="M9.13602134,19.8640447 L40.1781563,19.8640447 C40.730441,19.8640447 41.1781563,20.3117599 41.1781563,20.8640447 C41.1781563,21.1797513 41.0290717,21.4769179 40.7759964,21.66566 L25.7980655,32.8361132 C25.7704937,32.8566761 25.7418794,32.8758027 25.7123367,32.8934169 C25.5723927,32.9768553 25.4477534,33.0360265 25.3384188,33.0709303 C25.216665,33.1097987 25.0294175,33.1455407 24.7766762,33.1781563 C24.5274992,33.1446863 24.3411966,33.1089443 24.2177686,33.0709303 C24.1108512,33.0380013 23.9812479,32.9818503 23.8289587,32.9024773 L23.8289589,32.902477 C23.7834415,32.8787534 23.7398183,32.8515605 23.6984759,32.8211394 L8.5433489,21.6694883 C8.09851469,21.3421643 8.00325379,20.7162065 8.33057774,20.2713723 C8.51903062,20.0152642 8.81804995,19.8640447 9.13602134,19.8640447 Z" id="Rectangle" fill="currentColor" stroke="currentColor" transform="translate(24.657056, 26.521100) rotate(-90.000000) translate(-24.657056, -26.521100) "></path></g></svg>'


#'////////////////////////////////////////

# menu toggle
icons$menuToggle <- '<svg class="icon icon-menu-toggle" width="100%" height="100%" viewBox="0 0 20 20"><title>open or close content</title><polygon stroke="currentColor" fill="currentColor" points="9.29289322 12.9497475 10 13.6568542 15.6568542 8 14.2426407 6.58578644 10 10.8284271 5.75735931 6.58578644 4.34314575 8"/></svg>'


# menuToggleAlt - ideal for embedding inline
icons$menuToggleAlt <- '<svg class="icon icon-menu-toggle-alt" width="100%" height="100%" viewBox="0 0 20 20"><title>open or close content</title><polygon stroke="currentColor" fill="currentColor" points="9.29289322 12.9497475 10 13.6568542 15.6568542 8 14.2426407 6.58578644 10 10.8284271 5.75735931 6.58578644 4.34314575 8"/></svg>'


# restart icon primary
icons$restart <- '<svg width="50px" height="50px" viewBox="0 0 50 50" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="icon icon-restart">restart<title></title><path d="M40.9982944,33.634926 C42.2766089,31.2045528 43,28.4367549 43,25.5 C43,22.396187 42.1919675,19.4811002 40.7747866,16.9536235 C37.7789988,11.6107743 32.0611702,8 25.5,8 C15.8350169,8 8,15.8350169 8,25.5 C8,35.1649831 15.8350169,43 25.5,43 L25.5,43" id="Path" stroke="#4655a8" stroke-width="6" fill="none"></path><polygon id="Triangle" fill="#4655a8" transform="translate(39.500000, 33.722222) rotate(-139.000000) translate(-39.500000, -33.722222) " points="39.5 29 48 38.4444444 31 38.4444444"></polygon></svg>'


# restart icon alt - ideal for embedding in text
icons$restartAlt <- '<svg width="100%" height="100%" viewBox="0 0 60 60" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="icon icon-restart-alt"><title>restart</title><path d="M40.9982944,33.634926 C42.2766089,31.2045528 43,28.4367549 43,25.5 C43,22.396187 42.1919675,19.4811002 40.7747866,16.9536235 C37.7789988,11.6107743 32.0611702,8 25.5,8 C15.8350169,8 8,15.8350169 8,25.5 C8,35.1649831 15.8350169,43 25.5,43 L25.5,43" id="Path" stroke="#4655a8" stroke-width="6" fill="none"></path><polygon id="Triangle" fill="#4655a8" transform="translate(39.500000, 33.722222) rotate(-139.000000) translate(-39.500000, -33.722222) " points="39.5 29 48 38.4444444 31 38.4444444"></polygon></svg>'


# text increase
icons$textIncrease <- '<svg width="50px" height="50px" viewBox="0 0 50 50" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="icon icon-text-increase"><title>increase font size</title><g id="icon-increase-font" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" font-family="HelveticaNeue-Bold, Helvetica Neue" font-weight="bold"><g id="Group" transform="translate(5.000000, 6.000000)" fill="#4655a8"><text id="right" font-size="32" letter-spacing="2"><tspan x="16.04" y="31">A</tspan></text><text id="left" fill-opacity="0.6" font-size="21" letter-spacing="1.3125"><tspan x="0.15125" y="31">A</tspan></text></g></g></svg>'


# warning icon
icons$warning <- '<svg class="icon icon-warning" width="50px" height="50px" viewBox="0 0 50 50" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="icon" aria-hidden="true"><title>warning</title><desc>warning icon</desc><path d="M26.6061578,12.1646762 L45.131772,37.1323078 C45.7899548,38.0193643 45.6044161,39.2720282 44.7173596,39.930211 C44.3726637,40.1859703 43.9548322,40.3240532 43.5256142,40.3240532 L6.47438579,40.3240532 C5.36981629,40.3240532 4.47438579,39.4286227 4.47438579,38.3240532 C4.47438579,37.8948353 4.61246872,37.4770037 4.86822798,37.1323078 L23.3938422,12.1646762 C24.052025,11.2776198 25.3046889,11.092081 26.1917454,11.7502638 C26.3494827,11.8673026 26.489119,12.0069389 26.6061578,12.1646762 Z" id="Triangle" stroke="none" fill="currentColor"></path><circle id="exclaimation-dot" fill="#FFFFFF" cx="25" cy="35" r="2"></circle><path d="M25,19.875 L25,29.125" id="exclaimation-line" stroke="#FFFFFF" stroke-width="3" stroke-linecap="round"></path></svg>'
