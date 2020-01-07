# In Control of Effects 

This is a private repository for the *In Control of Effects* application. The In Control of Effects application is a decision making tool for potential antipsychotic medications based on unwanted side effects. The application is built using the [shiny](https://shiny.rstudio.com) framework for interactive applications in the R environment. 

## Tools

This application uses the following technologies.

- R/RStudio
- Shiny Framework for web applications in R
- SASS
- Git
- npm

There are two branches: master and dev. Please use the dev branch or a branch of your choice for all development work.

## Development

To work on the app. Switch over to the dev branch and pull the latest changes.

```bash
git checkout dev
git pull origin master
```

If you need to make any changes to the styles, you can start SASS by using the the `develop` script.

```bash
npm run develop
```

To start the shiny server, I have saved the following alias in my bash profile. I have found this to be very useful as I have develop shiny applications in VSCode as opposed to RStudio. I find it a bit easier to develop as there are lot of extensions available in VSCode, including R ones. This is a personal preference so feel free to use whichever program you are most comfortable with.

```bash
# in .bashprofile
alias shiny-server="Rscript -e 'shiny::runApp(launch.browser=FALSE, port=8000)'"
```

Then run the command in the root directory.

```
shiny-server
```

I would also recommend installing [tmux](https://github.com/tmux/tmux) for ease in development.

## Design

The following discusses the function and technical design of the application.

### Functional Design

The *In Control of Effects* application is simple and minimalist in functionality. In the application, users are presented with a series of information and instruction screens that lead to the selection of side effects. All side effects elements are structured in a UI component `card_input` that has an collapsible definition. The user must select 1 or 2 side effects to advance to the results screen. If the user fails to do so, an error message is displayed. On the results page, the user is presented with two lists of medications. The first list presents 3 medications that are recommended based on the selected side effects. The second list presents 3 medications to avoid. The medications are recommended based on the weighted means. From here, the user can more to the exit screen or start the questionnaire over.

In terms of features, there are few elements available. In the page header, there is a reset button. If clicked, it returns the user to the first page. A progress bar is displayed below the header. The bar decreases in width if the back button is clicked or increases if the next button is clicked.

### Technical Design

On the server-side, there is a bit of activity happening.

1. **Sigin**: This application is password protected as it is only available to study participants. New accounts are generated in the script `server/database/users.R` and saved in the file `users.RDS`. In the server, the users dataset is loaded and used to evaluate the signin form (username and password). The signin module can be found in `server/modules/login.R`. If the input values are correct, then the log-in status is set to `TRUE`, which triggers the loading and rendering of the first page.
1. **Loading and Rendering of Pages**: All pages are loaded and rendered server side. The html output is sent to client to the ui output element `app`. The first UI element to be rendered is the `app.R` UI. This is the primary page layout that will receive each sub-page. All sub-pages are located in the `src/pages/` path. The files are loaded dynamically and the order of the pages is defined in the object `file_order`. This allows us to manually set the routes of the application and add/remove pages during development. The reactive value `pageNum` is set to 1 by default and this value is updated (increased or decreased) based on which navigation button is clicked. When the number is changed, this allows loads the page specified in *nth* position in the object `file_paths`. The rendering of pages is handled by the page navigation module.
1. **Page Navigation**: The page navigation module updates the counter `pageNum` when the `next` or `previous` buttons are clicked, as well as `submit` and `start`. When the number is modified, this will load the next or previous page file and send it to the client. Some pages use UI components to standarize output elements. These elements are loaded globally in the server.
1. **Sourcing of Components**: As many of the pages use UI components and functions, all files are sourced in the server. This makes them available for all sub-pages.

This section will be updated once the database and analytics modules are completed.