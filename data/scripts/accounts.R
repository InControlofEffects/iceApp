## code to prepare `accounts` dataset goes here

accounts <- data.frame(
    username = c("admin", "standard"),
    password = c("admin12345", "standard12345")
)
accounts$password <- sapply(accounts$password, sodium::password_store)

saveRDS(accounts, "data/accounts.RDS")