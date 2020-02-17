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
  tabPanel(
    # The first argument is usually used as the tab title argument.
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
      dataTableOutput("table1", width = "100%", height = "auto")%>% 
        # The helper function is from the shinyhelper package.
        # It is used to include a help icon near the UI element attached to it.
        # It will send a message when clicked, the message will be in a folder in the
        # app's directory. The message file's format is .md (in markdown).
        helper(size = "l", 
               content = "TableHelp"),
      width = 12)),
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
    dataTableOutput("table2", width = "100%", height = "auto")%>% 
      helper(size = "l", 
             content = "TableHelp"),
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
      # The following code is for a workaround of the lack of a slider/box input widget.
      # Creating a well panel ui page display (it will wrap this element/s in a panel),
      wellPanel(
        # Creating a fluid row to place the box inputs and title in.
      fluidRow(
        # Placing each element in a column box input-Title-box input.
        column(3,style='padding:0px;',tags$style("#perm_min {font-size:10px;height:10px;}"),
      numericInput("perm_min", NULL, min = min(as.numeric(as.vector(membrane_data$P))), max = max(as.numeric(as.vector(membrane_data$P))), value = min(as.numeric(as.vector(membrane_data$P))))),
      column(6, HTML("<center><b>Permeability</b></center>")),
      column(3,style='padding:0px;',tags$style("#perm_max {font-size:10px;height:10px;}"),
             numericInput("perm_max", NULL, min = min(as.numeric(as.vector(membrane_data$P))), max = max(as.numeric(as.vector(membrane_data$P))), value = max(as.numeric(as.vector(membrane_data$P))))
      )),
      # Creating a fluid row to place the slider in.
      fluidRow(
        # Only one column is used for this fluid row.
      column(
        12,
        style='padding:0px;',
        # The sliderInput function is for the slider widget.
      sliderInput(
        'perm',
        label = NULL,
        min(as.numeric(as.vector(membrane_data$P))),
        max(as.numeric(as.vector(membrane_data$P))),
        value = c(min(as.numeric(
          as.vector(membrane_data$P)
        )), max(as.numeric(
          as.vector(membrane_data$P)
        ))),
        step = 1,
        width = 'auto'
      )))),
      # See the above comments to know more about the workaround of the 
      # lack of slide/box input widget issue.
      wellPanel(
      fluidRow(
        column(3,style='padding:0px;',tags$style("#alpha_min {font-size:10px;height:10px;}"),
               numericInput("alpha_min", NULL, min = min(as.numeric(as.vector(membrane_data$alph))), max = max(as.numeric(as.vector(membrane_data$alph))), value = min(as.numeric(as.vector(membrane_data$alph))))),
        column(6, HTML("<center><b>Selectivity</b></center>")),
        column(3,style='padding:0px;',tags$style("#alpha_max {font-size:10px;height:10px;}"),
               numericInput("alpha_max", NULL, min = min(as.numeric(as.vector(membrane_data$alph))), max = max(as.numeric(as.vector(membrane_data$alph))), value = max(as.numeric(as.vector(membrane_data$alph))))
        )),
      fluidRow(
        column(
          12,
          style='padding:0px;',
      sliderInput(
        'alpha',
        label = NULL,
        min(as.numeric(as.vector(membrane_data$alph))),
        max(as.numeric(as.vector(membrane_data$alph))),
        value = c(min(as.numeric(
          as.vector(membrane_data$alph)
        )), max(as.numeric(
          as.vector(membrane_data$alph)
        ))),
        step = 1,
        width = 'auto'
      )))),
      wellPanel(
        fluidRow(
          column(3,style='padding:0px;',tags$style("#yr_min {font-size:10px;height:10px;}"),
                 numericInput("yr_min", NULL, min = min(as.numeric(as.vector(membrane_data$Year))), max = max(as.numeric(as.vector(membrane_data$Year))), value = min(as.numeric(as.vector(membrane_data$Year))))),
          column(6, HTML("<center><b>Year</b></center>")),
          column(3,style='padding:0px;',tags$style("#yr_max {font-size:10px;height:10px;}"),
                 numericInput("yr_max", NULL, min = min(as.numeric(as.vector(membrane_data$Year))), max = max(as.numeric(as.vector(membrane_data$Year))), value = max(as.numeric(as.vector(membrane_data$Year))))
          )),
        fluidRow(
          column(
            12,
            style='padding:0px;',
      sliderInput(
        'yr',
        label = NULL,
        min(as.numeric(as.vector(membrane_data$Year))),
        max(as.numeric(as.vector(membrane_data$Year))),
        value = c(min(as.numeric(
          as.vector(membrane_data$Year)
        )), max(as.numeric(
          as.vector(membrane_data$Year)
        ))),
        sep = "",
        width = 'auto'
      )))),
      # The pickerInput widget is for the dropdown pick list widget.
      wellPanel(
      pickerInput(
        inputId = "jour",
        label = "Journals",
        choices = as.character(unique(membrane_data$Journal)),
        # The multiple argument allows for multiple choices.
        multiple = TRUE,
        options = pickerOptions(
          actionsBox = TRUE,
          size = 10,
          selectedTextFormat = "count > 3",
          # The liveSearch argument is to include a search option.
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        )
      )),
      wellPanel(
      pickerInput(
        inputId = "auth",
        label = "Author",
        choices = as.character(unique(membrane_data$Corresponding.Author)),
        multiple = TRUE,
        options = pickerOptions(
          actionsBox = TRUE,
          size = 12,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        )
      )),
      wellPanel(
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
          actionsBox = TRUE,
          size = 12,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        )
      )),
      wellPanel(
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
          actionsBox = TRUE,
          size = 12,
          selectedTextFormat = "count > 3",
          liveSearch = TRUE,
          liveSearchNormalize = TRUE,
          liveSearchStyle = 'contains'
        )
      )),
      
      # The following argument are for the dropdown function, and are used to style
      # it mostly.
      style = "unite",
      icon = icon("gear"),
      status = "danger",
      width = "400px",
      animate = animateOptions(
        enter = animations$fading_entrances$fadeInLeftBig,
        exit = animations$fading_exits$fadeOutRightBig
      )
    )
    ,
    # Here I am using plotlyOutput to include the plotly object in the main panel.
    mainPanel(
      # Declare toastr usage. This allows for the usage of notifications from
      # the shinytoastr package. The code processing these notifications is in the server script.
      useToastr(),
      plotlyOutput(
      "plot1", width = "100%", height = "100%"
    ) %>% 
      helper(size = "l", 
             content = "PlotHelp"),
    width =
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
      # The switchInput function is for the switch widget.
      switchInput(
        # As in any user input widget, you must give the widget a name,
        # here it is "typ."
        # Google or use help() to findout more about the widgets arguments.
        "typ2",
        label = "Color Types",
        onLabel = "ON",
        offLabel = "OFF"
      ),
      # The following code is for a workaround of the lack of a slider/box input widget.
      # Creating a well panel ui page display (it will wrap this element/s in a panel),
      wellPanel(
        # Creating a fluid row to place the box inputs and title in.
        fluidRow(
          # Placing each element in a column box input-Title-box input.
          column(3,style='padding:0px;',tags$style("#perm2_min {font-size:10px;height:10px;}"),
                 numericInput("perm2_min", NULL, min = min(as.numeric(as.vector(membrane_data2$P))), max = max(as.numeric(as.vector(membrane_data2$P))), value = min(as.numeric(as.vector(membrane_data2$P))))),
          column(6, HTML("<center><b>Permeability</b></center>")),
          column(3,style='padding:0px;',tags$style("#perm2_max {font-size:10px;height:10px;}"),
                 numericInput("perm2_max", NULL, min = min(as.numeric(as.vector(membrane_data2$P))), max = max(as.numeric(as.vector(membrane_data2$P))), value = max(as.numeric(as.vector(membrane_data2$P))))
          )),
        # Creating a fluid row to place the slider in.
        fluidRow(
          # Only one column is used for this fluid row.
          column(
            12,
            style='padding:0px;',
            # The sliderInput function is for the slider widget.
            sliderInput(
              'perm2',
              label = NULL,
              min(as.numeric(as.vector(membrane_data2$P))),
              max(as.numeric(as.vector(membrane_data2$P))),
              value = c(min(as.numeric(
                as.vector(membrane_data2$P)
              )), max(as.numeric(
                as.vector(membrane_data2$P)
              ))),
              step = 1,
              width = 'auto'
            )))),
      # See the above comments to know more about the workaround of the 
      # lack of slide/box input widget issue.
      wellPanel(
        fluidRow(
          column(3,style='padding:0px;',tags$style("#alpha2_min {font-size:10px;height:10px;}"),
                 numericInput("alpha2_min", NULL, min = min(as.numeric(as.vector(membrane_data2$alph))), max = max(as.numeric(as.vector(membrane_data2$alph))), value = min(as.numeric(as.vector(membrane_data2$alph))))),
          column(6, HTML("<center><b>Selectivity</b></center>")),
          column(3,style='padding:0px;',tags$style("#alpha2_max {font-size:10px;height:10px;}"),
                 numericInput("alpha2_max", NULL, min = min(as.numeric(as.vector(membrane_data2$alph))), max = max(as.numeric(as.vector(membrane_data2$alph))), value = max(as.numeric(as.vector(membrane_data2$alph))))
          )),
        fluidRow(
          column(
            12,
            style='padding:0px;',
            sliderInput(
              'alpha2',
              label = NULL,
              min(as.numeric(as.vector(membrane_data2$alph))),
              max(as.numeric(as.vector(membrane_data2$alph))),
              value = c(min(as.numeric(
                as.vector(membrane_data2$alph)
              )), max(as.numeric(
                as.vector(membrane_data2$alph)
              ))),
              step = 1,
              width = 'auto'
            )))),
      wellPanel(
        fluidRow(
          column(3,style='padding:0px;',tags$style("#yr2_min {font-size:10px;height:10px;}"),
                 numericInput("yr2_min", NULL, min = min(as.numeric(as.vector(membrane_data2$Year))), max = max(as.numeric(as.vector(membrane_data2$Year))), value = min(as.numeric(as.vector(membrane_data2$Year))))),
          column(6, HTML("<center><b>Year</b></center>")),
          column(3,style='padding:0px;',tags$style("#yr2_max {font-size:10px;height:10px;}"),
                 numericInput("yr2_max", NULL, min = min(as.numeric(as.vector(membrane_data2$Year))), max = max(as.numeric(as.vector(membrane_data2$Year))), value = max(as.numeric(as.vector(membrane_data2$Year))))
          )),
        fluidRow(
          column(
            12,
            style='padding:0px;',
            sliderInput(
              'yr2',
              label = NULL,
              min(as.numeric(as.vector(membrane_data2$Year))),
              max(as.numeric(as.vector(membrane_data2$Year))),
              value = c(min(as.numeric(
                as.vector(membrane_data2$Year)
              )), max(as.numeric(
                as.vector(membrane_data2$Year)
              ))),
              sep = "",
              width = 'auto'
            )))),
      # The pickerInput widget is for the dropdown pick list widget.
      wellPanel(
        pickerInput(
          inputId = "jour2",
          label = "Journals",
          choices = as.character(unique(membrane_data2$Journal)),
          # The multiple argument allows for multiple choices.
          multiple = TRUE,
          options = pickerOptions(
            actionsBox = TRUE,
            size = 10,
            selectedTextFormat = "count > 3",
            # The liveSearch argument is to include a search option.
            liveSearch = TRUE,
            liveSearchNormalize = TRUE,
            liveSearchStyle = 'contains'
          )
        )),
      wellPanel(
        pickerInput(
          inputId = "auth2",
          label = "Author",
          choices = as.character(unique(membrane_data2$Corresponding.Author)),
          multiple = TRUE,
          options = pickerOptions(
            actionsBox = TRUE,
            size = 12,
            selectedTextFormat = "count > 3",
            liveSearch = TRUE,
            liveSearchNormalize = TRUE,
            liveSearchStyle = 'contains'
          )
        )),
      wellPanel(
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
            size = 12,
            selectedTextFormat = "count > 3",
            liveSearch = TRUE,
            liveSearchNormalize = TRUE,
            liveSearchStyle = 'contains'
          )
        )),
      wellPanel(
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
            size = 12,
            selectedTextFormat = "count > 3",
            liveSearch = TRUE,
            liveSearchNormalize = TRUE,
            liveSearchStyle = 'contains'
          )
        )),
      
      # The following argument are for the dropdown function, and are used to style
      # it mostly.
      style = "unite",
      icon = icon("gear"),
      status = "danger",
      width = "400px",
      animate = animateOptions(
        enter = animations$fading_entrances$fadeInLeftBig,
        exit = animations$fading_exits$fadeOutRightBig
      )
    ),
    # Here I am using plotlyOutput to include the plotly object in the main panel.
    mainPanel(
      # Declare toastr usage. This allows for the usage of notifications from
      # the shinytoastr package. The code processing these notifications is in the server script.
      useToastr(),
      plotlyOutput(
        "plot2", width = "100%", height = "100%"
      ) %>% 
        helper(size = "l", 
               content = "PlotHelp"),
      width =
        12)
  ),
  # This About tab is to be formatted using HTML tags.
  # An icon is used here in place of a title.
  tabPanel(icon("info-circle"),
           # Fluid Page is a type of UI display. It can be used when you want to specifiy the
           # location of an element.
           fluidPage(
             column(7, offset = 2,
          # A well panel is a type of UI display.
           wellPanel(
             # The following line reads and shows an html formatted text file.
             HTML(readChar('about_html.txt',file.info('about_html.txt')$size))
           )
             )
           )
)
)


