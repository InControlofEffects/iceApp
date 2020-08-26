
![in control of effects project](incontrolofeffects.png)

# In Control of Effects

The In Control of Effects application is a shiny app that provides antipsychotic medication recommendations based on an individual's preference for avoiding side effects. This project aims to initiate a discussion between the individual and their psychiatrist regarding antipsychotic medications and the risk of side effects.

The `iceApp` package contains all of the code used to create and run the Shiny app. The app was developed using the Shiny framework [golem](https://github.com/ThinkR-open/golem) and the following packages (also developed by the In Control of Effects project)

- [iceData](https://github.com/InControlofEffects/iceData): an R package containing the primary dataset and user preferences function
- [iceComponents](https://github.com/InControlofEffects/iceComponents): all custom Shiny UI components were bundled into an R package
- [browsertools](https://github.com/davidruvolo51/browsertools): a package for communication between R and the client
- [rheroicons](https://github.com/davidruvolo51/rheroicons): the Heroicons library for R

## Use

Install the package using the following command.

```r
devtools::install_github("InControlofEffects/iceApp")
```

The app can be viewed locally by running `run_app`.

```r
iceApp::run_app()
```

The package comes with a demo account.

- username: `wallaby`
- password: `wall2200`


## Disclaimer

The `iceApp` package and all related projects created by by the In Control of Effects projects are part of ongoing research led by researchers at the University of Oxford. Any tool produced by the In Control of Effects project does not replace medical treatment or consultation with any healthcare professional. Any information produced by this tool should be discussed with an individual's psychiatrist or other healthcare provider as this app does not take into account individual patient characteristics, pre-existing medical conditions, any current medical treatment or medications may already be prescribed.


## References

1. Huhn, M., Nikolakopoulou, A., Schneider-Thoma, J., Krause, M., Samara, M., Peter, N., ... & Davis, J. (2019). Comparative efficacy and tolerability of 32 oral antipsychotics for the acute treatment of adults with multi-episode schizophrenia: a systematic review and network meta-analysis. The Lancet, 394(10202), 939-951. [http://dx.doi.org/10.1016/S0140-6736(19)31135-3](http://dx.doi.org/10.1016/S0140-6736(19)31135-3)

2. Henshall, C., Cipriani, A., Ruvolo, D., Macdonald, O., Wolters, L., & Koychev, I. (2019). Implementing a digital clinical decision support tool for side effects of antipsychotics: a focus group study. Evidence-Based Mental Health (22), 56-60. [http://dx.doi.org/10.1136/ebmental-2019-300086](http://dx.doi.org/10.1136/ebmental-2019-300086)
