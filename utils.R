# Function to generate city names
ch_city <- function(n = 1, locale = NULL) {
  if (n == 1) {
    AddressProvider$new(locale = locale)$city()
  } else {
    x <- AddressProvider$new(locale = locale)
    replicate(n, x$city())
  }
}

# Function to generate emails
ch_email <- function(n = 1, locale = NULL) {
  if (n == 1) {
    InternetProvider$new(locale = locale)$email()
  } else {
    x <- InternetProvider$new(locale = locale)
    replicate(n, x$email())
  }
}

# Function to create table with variables outside generic ch_generate
genTable <- function(variables, rows) {
  cols <- stats::setNames(
    lapply(variables, function(var) {
      fun <- eval(parse(text = paste0("ch_", var)))
      fun(rows)
    }),
    variables
  )
  tibble::as_tibble(cols)
}