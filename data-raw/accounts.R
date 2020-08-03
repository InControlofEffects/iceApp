## code to prepare `accounts` dataset goes here

accounts <- data.frame(
    username = c("currawong", "wagtail"),
    password = c("", ""),
    type = c("admin", "standard")
)
accounts$password <- sapply(accounts$password, sodium::password_store)

usethis::use_data(accounts, overwrite = TRUE, internal = TRUE)
