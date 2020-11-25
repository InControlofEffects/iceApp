
![in control of effects project](incontrolofeffects.png)

# In Control of Effects

The In Control of Effects application is a shiny app that provides antipsychotic medication recommendations based on an individual's preference for avoiding side effects. This project aims to initiate a discussion between the individual and their psychiatrist regarding antipsychotic medications and the risk of side effects.

The `iceApp` package contains all of the code used to create and run the Shiny app. The app was developed using the Shiny framework [golem](https://github.com/ThinkR-open/golem) and the following packages (also developed by the In Control of Effects project)

- [iceData](https://github.com/InControlofEffects/iceData): an R package containing the primary dataset and user preferences function
- [iceComponents](https://github.com/InControlofEffects/iceComponents): all custom Shiny UI components were bundled into an R package
- [browsertools](https://github.com/davidruvolo51/browsertools): a package for communication between R and the client
- [rheroicons](https://github.com/davidruvolo51/rheroicons): the Heroicons library for R

## Getting Started

There are few things that will need to be configured before you can run the app.

### Install `iceApp`

First, install the latest release from GitHub.

```r
remotes::install_github("InControlofEffects/iceApp@*release")
```

### Create a New Projects

Create the following folders and files.

```text
my-app /
    + data /
        - data.R
    + app.R
```

### Create User Accounts

In the file `data/data.R`, create a user accounts database using the `sodium` package.

```r
# create object
db <- data.frame(
    username = "test",
    password = "test1234",
    type = "demo-user"
)

# hash password
db$password <- sapply(db$password, sodium::password_store)

# save file
saveRDS(db, "path/to/users.RDS")
```

### Setup the app

In the `app.R` file, call the main run function. Define the path to the users database. You can also disable the analytics module and specify the path for the logs.

```r
iceApp::run_app(
    use_analytics = TRUE,
    users_db_path = "app-data/accounts.RDS",
    out_dir = "app-data/logs/"
)
```

## Disclaimer

The `iceApp` package and all related projects created by by the In Control of Effects projects are part of ongoing research led by researchers at the University of Oxford. Any tool produced by the In Control of Effects project does not replace medical treatment or consultation with any healthcare professional. Any information produced by this tool should be discussed with an individual's psychiatrist or other healthcare provider as this app does not take into account individual patient characteristics, pre-existing medical conditions, any current medical treatment or medications may already be prescribed.

## References

1. Huhn, M., Nikolakopoulou, A., Schneider-Thoma, J., Krause, M., Samara, M., Peter, N., ... & Davis, J. (2019). Comparative efficacy and tolerability of 32 oral antipsychotics for the acute treatment of adults with multi-episode schizophrenia: a systematic review and network meta-analysis. The Lancet, 394(10202), 939-951. [http://dx.doi.org/10.1016/S0140-6736(19)31135-3](http://dx.doi.org/10.1016/S0140-6736(19)31135-3)

2. Henshall, C., Cipriani, A., Ruvolo, D., Macdonald, O., Wolters, L., & Koychev, I. (2019). Implementing a digital clinical decision support tool for side effects of antipsychotics: a focus group study. Evidence-Based Mental Health (22), 56-60. [http://dx.doi.org/10.1136/ebmental-2019-300086](http://dx.doi.org/10.1136/ebmental-2019-300086)
