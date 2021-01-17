# init.R
#
# Example R code to install packages if not already installed
#

my_packages = c("shiny", "ggplot2", "dplyr", "shinyWidgets", "graphics", "purrr", "DT", "shinydashboard")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p, dependencies = TRUE)
  }
}

invisible(sapply(my_packages, install_if_missing))