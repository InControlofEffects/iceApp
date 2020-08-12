# Test your app

## Run checks ----
## Check the package before sending to prod
devtools::check()
devtools::test()

# Deploy
golem::add_shinyserver_file()
