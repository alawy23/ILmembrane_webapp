# This R script is meant to hold the UI part of the web app only.
# Many things are first introduced here such as the widgets and the app layout.

# I am introducing my data bases here
membrane_data <-
  read.xlsx2("data/IL_Robeson_R.xlsx", 1)

membrane_data2 <-
  read.xlsx2("data/IL_Robeson_R.xlsx", 2)

# I will use a navbar page layout for this app, which allows me to add a navigation bar to
# hold my tabs.
navbarPage(
  "Ionic Liquids Membranes",
  # linking the themes argument to the shinythemes package.
  # Uncomment the following line to view a different theme:
  #themeSelector(),
  theme = shinytheme("sandstone"),
  # The tabPanel function is used to introduce a new tab
  tabPanel(# The first line is usually used as the tab title argument.
    # The HTML function is pretty useful in Shiny.
    # It can be used to include html formatting to text.
    HTML(paste(
      tags$p(
        "CO",
        tags$sub(tags$small("2")),
        "/N",
        tags$sub(tags$small("2")),
        "Data"
      )
    )),
    # The mainPanel function is used to hold the main page in the parent tab.
    mainPanel(
      # Here I am refering to "table1" which can be seen in the server script
      # refering to the first sheet of the Excel File.
      DT::dataTableOutput("table1", width = "100%", height = "auto"),
      width = 12
    )),
  tabPanel(HTML(paste(
    tags$p(
      "CO",
      tags$sub(tags$small("2")),
      "/CH",
      tags$sub(tags$small("4")),
      "Data"
    )
  )),
  mainPanel(
    DT::dataTableOutput("table2", width = "100%", height = "auto"),
    width = 12
  )),
  tabPanel(
    HTML(paste(
      tags$p(
        "CO",
        tags$sub(tags$small("2")),
        "/N",
        tags$sub(tags$small("2")),
        "Plot"
      )
    )),
    # The dropdown function (from shinyWidgets) is used to create a dropdown
    # panel. Which holds the other widgets here.
    dropdown(
      # The switchInput function is for the switch widget.
      switchInput(
        # As in any user input widget, you must give the widget a name,
        # here it is "typ."
        # Google or use help() to findout more about the widgets arguments.
        "typ",
        label = "Color Types",
        onLabel = "ON",
        offLabel = "OFF"
      ),
      # The sliderInput function is for the slider widget.
      sliderInput(
        'perm',
        label = 'Permeability',
        min(as.numeric(as.vector(membrane_data$P))),
        max(as.numeric(as.vector(membrane_data$P))),
        value = c(min(as.numeric(
          as.vector(membrane_data$P)
        )), max(as.numeric(
          as.vector(membrane_data$P)
        )))
      ),
      sliderInput(
        'alpha',
        label = 'Selectivity',
        min(as.numeric(as.vector(membrane_data$alph))),
        max(as.numeric(as.vector(membrane_data$alph))),
        value = c(min(as.numeric(
          as.vector(membrane_data$alph)
        )), max(as.numeric(
          as.vector(membrane_data$alph)
        )))
      ),
      sliderInput(
        'yr',
        label = 'Year',
        min(as.numeric(as.vector(membrane_data$Year))),
        max(as.numeric(as.vector(membrane_data$Year))),
        value = c(min(as.numeric(
          as.vector(membrane_data$Year)
        )), max(as.numeric(
          as.vector(membrane_data$Year)
        )))
      ),
      # The pickerInput widget is for the dropdown pick list widget.
      pickerInput(
        inputId = "jour",
        label = "Journals",
        choices = as.character(unique(membrane_data$Journal)),
        # The multiple argument allows for multiple choices.
        multiple = TRUE,
        options = pickerOptions(
          mobile = TRUE,
          actionsBox = TRUE,
          size = 10,
          selectedTextFormat = "count > 3",
          # The liveSearch argument is to include a search option.
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        ),
      ),
      pickerInput(
        inputId = "auth",
        label = "Authors",
        choices = as.character(unique(membrane_data$Authors)),
        multiple = TRUE,
        options = pickerOptions(
          mobile = TRUE,
          actionsBox = TRUE,
          size = 10,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        ),
      ),
      pickerInput(
        inputId = "cati",
        label = "Cation",
        choices = c(as.character(unique(
          membrane_data$IL.Cation.name
        )), as.character(
          unique(membrane_data$PIL.Monomer.Cation.name)
        ))[!c(as.character(unique(membrane_data$IL.Cation.name)), as.character(unique(membrane_data$PIL.Monomer.Cation.name))) %in% c("", "-")],
        multiple = TRUE,
        options = pickerOptions(
          mobile = TRUE,
          actionsBox = TRUE,
          size = 10,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        ),
      ),
      pickerInput(
        inputId = "ani",
        label = "Anion",
        choices = c(as.character(unique(
          membrane_data$IL.Anion.name
        )), as.character(unique(
          membrane_data$PIL.Anion.name
        )))[!c(as.character(unique(membrane_data$IL.Anion.name)), as.character(unique(membrane_data$PIL.Anion.name))) %in% c("", "-")],
        multiple = TRUE,
        options = pickerOptions(
          mobile = TRUE,
          actionsBox = TRUE,
          size = 10,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        ),
      ),
      
      # The following argument are for the dropdown function, and are used to style
      # it mostly.
      style = "unite",
      icon = icon("gear"),
      status = "danger",
      width = "300px",
      animate = animateOptions(
        enter = animations$fading_entrances$fadeInLeftBig,
        exit = animations$fading_exits$fadeOutRightBig
      )
    )
    ,
    # Here I am using plotlyOutput to include the plotly object in the main panel.
    mainPanel(plotlyOutput(
      "plot1", width = "100%", height = "100%"
    ), width =
      12)
  ),
  # I am repeating the above tab for the CO2/CH4 data here.
  tabPanel(
    HTML(paste(
      tags$p(
        "CO",
        tags$sub(tags$small("2")),
        "/CH",
        tags$sub(tags$small("4")),
        "Plot"
      )
    )),
    dropdown(
      switchInput(
        "typ2",
        label = "Color Types",
        onLabel = "ON",
        offLabel = "OFF"
      ),
      
      sliderInput(
        'perm2',
        label = 'Permeability',
        min(as.numeric(as.vector(membrane_data2$P))),
        max(as.numeric(as.vector(membrane_data2$P))),
        value = c(min(as.numeric(
          as.vector(membrane_data2$P)
        )), max(as.numeric(
          as.vector(membrane_data2$P)
        )))
      ),
      sliderInput(
        'alpha2',
        label = 'Selectivity',
        min(as.numeric(as.vector(
          membrane_data2$alph
        ))),
        max(as.numeric(as.vector(
          membrane_data2$alph
        ))),
        value = c(min(as.numeric(
          as.vector(membrane_data2$alph)
        )), max(as.numeric(
          as.vector(membrane_data2$alph)
        )))
      ),
      sliderInput(
        'yr2',
        label = 'Year',
        min(as.numeric(as.vector(
          membrane_data2$Year
        ))),
        max(as.numeric(as.vector(
          membrane_data2$Year
        ))),
        value = c(min(as.numeric(
          as.vector(membrane_data2$Year)
        )), max(as.numeric(
          as.vector(membrane_data2$Year)
        )))
      ),
      pickerInput(
        inputId = "jour2",
        label = "Journals",
        choices = as.character(unique(membrane_data2$Journal)),
        multiple = TRUE,
        options = pickerOptions(
          actionsBox = TRUE,
          size = 10,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        ),
      ),
      pickerInput(
        inputId = "auth2",
        label = "Authors",
        choices = as.character(unique(membrane_data2$Authors)),
        multiple = TRUE,
        options = pickerOptions(
          actionsBox = TRUE,
          size = 10,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        ),
      ),
      pickerInput(
        inputId = "cati2",
        label = "Cation",
        choices = c(as.character(unique(
          membrane_data2$IL.Cation.name
        )), as.character(
          unique(membrane_data2$PIL.Monomer.Cation.name)
        ))[!c(as.character(unique(membrane_data2$IL.Cation.name)), as.character(unique(membrane_data2$PIL.Monomer.Cation.name))) %in% c("", "-")],
        multiple = TRUE,
        options = pickerOptions(
          actionsBox = TRUE,
          size = 10,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        ),
      ),
      pickerInput(
        inputId = "ani2",
        label = "Anion",
        choices = c(as.character(unique(
          membrane_data2$IL.Anion.name
        )), as.character(unique(
          membrane_data2$PIL.Anion.name
        )))[!c(as.character(unique(membrane_data2$IL.Anion.name)), as.character(unique(membrane_data2$PIL.Anion.name))) %in% c("", "-")],
        multiple = TRUE,
        options = pickerOptions(
          actionsBox = TRUE,
          size = 10,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        ),
      ),
      
      style = "unite",
      icon = icon("gear"),
      status = "danger",
      width = "300px",
      animate = animateOptions(
        enter = animations$fading_entrances$fadeInLeftBig,
        exit = animations$fading_exits$fadeOutRightBig
      )
    )
    ,
    mainPanel(plotlyOutput(
      "plot2", width = "100%", height = "100%"
    ), width =
      12)
  ),
  # This About tab is to be formatted using HTML tags.
  tabPanel("About",
           mainPanel(withTags(div(
             h1("About this Project"),
             p("Write stuff here")
             
             
           ))))
)

