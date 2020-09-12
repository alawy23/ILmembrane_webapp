# The global script is called before all the others, so I am using it to call all
# the packages I used in the code.

# The following lines are necessary to introduce the packages used in the app.
# The shiny package is what was used to create the web apps.
library(shiny)
# The plotly package is what I used to create the interactive plots here.
library(plotly)
# The stringer package is used for string manipulation.
library(stringr)
# The tidyverse is a collection of very useful packages.
library(tidyverse)
# The shinyWidgets package introduces more interactive widgets to the web app.
library(shinyWidgets)
# The shinythemes package makes changing the web app theme easy.
# CSS theme scripts can be used alternatively.
library(shinythemes)
# htmlwidgets is used to introduce a number of widgets and elements.
library(htmlwidgets)
# DT is used to create the data tables used in the app.
library(DT)
# shinytoastr is used to make the notifications used as a tutorial in the app.
library(shinytoastr)
# shinyhelper is the package used to create the helper icon and message atop of the
# plots and data tables in the app.
library(shinyhelper)