# The global script is called before all the others, so I am using it to call all
# the packages I used in the code.

# The following lines are necessary to introduce the packages used in the app.
# The shiny package is what was used to create the web apps.
library(shiny)
# The xlsx package is what I used to easily import my Excel data. It can also be used to
# manipulate the Excel file, which can be very useful, but not used here.
library(xlsx)
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
