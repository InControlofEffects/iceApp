#'//////////////////////////////////////////////////////////////////////////////
#' FILE: patient_prefs.R
#' AUTHOR: David Ruvolo
#' CREATED: 2017-03-06
#' MODIFIED: 2019-12-11
#' PURPOSE: processing user input and producing new scores per drug
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: x = input values
#'//////////////////////////////////////////////////////////////////////////////
patientPrefs <- function(x){
    
    # user inputs (e.g., selection)
    patientPreferences_iS <- as.numeric(x)
    
    # Create required data structures
    drugSumptoms_iMiS <- as.matrix( antiPsychDF[ , -1  ] )
    patientPreferences_iM <- drugSumptoms_iMiS[ ,1] * 0
    names( patientPreferences_iM ) <- antiPsychDF[ ,1]
    
    # Build a new score per drug, using the average of the symptoms per drug 
    # weighted to the preferences of the patient
    for( iM in 1:dim( antiPsychDF )[1] ){
        patientPreferences_iM[iM] <- sum( drugSumptoms_iMiS[iM, ] * patientPreferences_iS )
    }
    
    # Sort the drugs according to the new score
    sort( patientPreferences_iM )
    
}