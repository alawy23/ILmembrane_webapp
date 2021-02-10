# Adapted from github.com/dataprofessor/iris-r-heroku

# init.R
#
# Example R code to install packages if not already installed
#

my_packages = c("shiny", "plotly", "stringr", "tidyverse", "shinyWidgets",
                "shinythemes", "htmlwidgets", "DT", "shinytoastr", "shinyhelper")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

invisible(sapply(my_packages, install_if_missing))