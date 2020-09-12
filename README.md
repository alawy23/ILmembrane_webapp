# Ionic Liquid Membrane Data Web App
This R web app (made with shiny and plotly). Takes manually collected ionic liquid membrane data and plots them in an interactive fashion.

## This repository holds the following scripts:
- data folder: 
  - This folder holds the membrane data Excel file named (IL_Robeson_R.xlsx)
- App.R:
  - This script is the app's parent script, which sources the server.R and ui.R scripts.
- global.R:
  - This script runs before any other script, which makes it useful to include the package calls (i.e. library())
  and any international support.
- ui.R:
  - This script holds the code required for setting up the user interface, such as the page layout. 
  Widgets are first introduced here too, and are also position in the page.
- server.R:
  - This scripts holds the code that provides the UI with outputs and corresponds to the ui inputs.
- plot_builder.R:
  - This script holds the function that makes the plotly plot. It is a custom function that holds 
  the plot_ly function inside it. Its arguments are mostly user inputs from the widgets, which makes
  the necessary changes to the plot.
- conditional_window.R:
  - This script hold the function that produces strings with html tags that are needed to make the SweetAlert 
  conditional table. This means that each point will show a differently formatted SweetAlert, depending on its type.

## App Demo:
- This gif shows a quick example of how this app is used.
  ![](IL_membrane_webapp.gif)
- I will include a link here to it soon.

## Packages Used:
- shiny: 
  - http://shiny.rstudio.com
  - https://cran.r-project.org/web/packages/shiny/index.html
- Plotly: 
  -	https://plotly-r.com
  - https://cran.r-project.org/web/packages/plotly/index.html
- Stringr: 
  -	http://stringr.tidyverse.org
  - https://cran.r-project.org/web/packages/stringr/index.html
- Tidyverse: 
  -	http://tidyverse.tidyverse.org
  - https://cran.r-project.org/web/packages/tidyverse/index.html
- Shinywidgets: 
  -	https://github.com/dreamRs/shinyWidgets
  - https://cran.r-project.org/web/packages/shinyWidgets/index.html
- Shinythemes: 
  - http://rstudio.github.io/shinythemes/
  - https://cran.r-project.org/web/packages/shinythemes/index.html
- Htmlwidgets: 
  - https://github.com/ramnathv/htmlwidgets
  - https://cran.r-project.org/web/packages/htmlwidgets/index.html
- DT: 
  - https://github.com/rstudio/DT
  - https://cran.r-project.org/web/packages/DT/index.html
- Shinytoastr: 
  - https://github.com/mangothecat/shinytoastr
  - https://cran.r-project.org/web/packages/shinytoastr/index.html
- Shinyhelper: 
  -	https://github.com/cwthom/shinyhelper
  - https://cran.r-project.org/web/packages/shinyhelper/index.html

## About:
- I will add the about section soon.
