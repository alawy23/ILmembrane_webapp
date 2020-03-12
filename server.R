# This script is for the server part of the web app.
# Here UI objects are linked with inputs or outputs.

server <- function(input, output, session) {
  # Deaclare usage of shinyhelpers. The withMathJax arguments makes it
  # possible to use MathJax in markdown for the helper pop-up.
  observe_helpers(withMathJax = TRUE)
  
  # sourcing the functions to be used here.
  source('plot_builder.R')
  source('conditional_window.R')
  # The follwing code renders and styles the data table tab.
  output$table1 <- renderDataTable({
    membrane_data = read.xlsx2("data/IL_Robeson_R.xlsx", 1)
    # The following lines remove unecessary metadata for the data tab.
    membrane_data = subset(
      membrane_data,
      select = -c(
        Type_cond,
        Material.1,
        Material.2,
        Material.3,
        Material.4,
        Material.5,
        Material.6,
        Notes,
        Institutions,
        Corresponding.Author,
        Corresponding.Author.Email,
        Corresponding.Author.Institution,
        P.CO2..Error,
        alphErr,
        J_abb,
        Page,
        Volume
      )
    )
    # The following lines reorders thecolumn of the database used for the data tab.
    membrane_data = membrane_data[c(
      "Full.Name",
      "Abbreviation",
      "Type",
      "P",
      "alph",
      "IL.Cation.name",
      "IL.Cation.SMILE",
      "IL.Anion.name",
      "IL.Anion.SMILE",
      "PIL.Monomer.Cation.name",
      "PIL.Monomer.Cation.SMILE",
      "PIL.Anion.name",
      "PIL.Anion.SMILE",
      "Support.Copolymer.metal.organic.framework..MOF.",
      "Temperatures..degC.",
      "Pressures..bar.",
      "Year",
      "Article.Title",
      "Authors",
      "Journal",
      "DOI.URL"
    )]
  }, filter = 'top',
  # The "Buttons" and "Select" extensions are used to make copying from the data tab available.
  extensions = c("Buttons", "Select"),
  selection = 'none',
  server = FALSE,
  # The following lines renames the columns.
  colnames = c(
    "Full Name" = "Full.Name",
    "Permeability (Barrer)" = "P",
    "Selectivity" = "alph",
    "IL Cation Name" = "IL.Cation.name",
    "IL Cation SMILE" = "IL.Cation.SMILE",
    "IL Anion Name" = "IL.Anion.name",
    "IL Anion SMILE" = "IL.Anion.SMILE",
    "PIL Monomer Cation Name" = "PIL.Monomer.Cation.name",
    "PIL Monomer Cation SMILE" = "PIL.Monomer.Cation.SMILE",
    "PIL Anion Name" = "PIL.Anion.name",
    "PIL Anion SMILE" = "PIL.Anion.SMILE",
    "Other Materials" = "Support.Copolymer.metal.organic.framework..MOF.",
    "Temperature (DegC)" = "Temperatures..degC.",
    "Pressure (bar)" = "Pressures..bar.",
    "Article Title" = "Article.Title",
    "DOI Link" = "DOI.URL"
  ),
  # The following JS code is to check if clicked on a row (from Batanichek in stackoverflow).
  # Checking whether a row is clicked will be used to send tutorial notifications.
  callback = JS(
    "table.on('click.dt', 'td', function() {
            var row_=table.cell(this).index().row;
            var col=table.cell(this).index().column;
            var rnd= Math.random();
            var data = [row_, col, rnd];
           Shiny.onInputChange('rows1',data );
    });"
  ),
  options = list(
    select = TRUE,
    dom = "Blfrtip",
    scrollX = TRUE,
    autoWidth = TRUE,
    # Declare the copy button in datatable.
    buttons = list(list(
      extend = "copy",
      text = 'Copy',
      exportOptions = list(modifier = list(selected = TRUE))
    )),
    # The columnDefs are used to control the size and format of the columns.
    columnDefs = list(
      list(width = '300px', targets = c(1, 2, 18, 19, 20)),
      list(
        width = '475px',
        targets = c(6, 7, 8, 9, 10, 11, 12, 13, 14)
      ),
      list(width = '100px', targets = c(3)),
      list(
        targets = c(1, 2, 18, 19, 20),
        # The render argument JS code is courtsy of the official DT package
        # DataTable Options tutorial page, edited to my specs.
        render = JS(
          "function(data, type, row, meta) {",
          "return type === 'display' && data.length > 50 ?",
          "'<span title=\"' + data + '\">' + data.substr(0, 40) + '...</span>' : data;",
          "}"
        )
      ),
      list(
        targets = c(6, 7, 8, 9, 10, 11, 12, 13, 14),
        render = JS(
          "function(data, type, row, meta) {",
          "return type === 'display' && data.length > 70 ?",
          "'<span title=\"' + data + '\">' + data.substr(0, 60) + '...</span>' : data;",
          "}"
        )
      )
    )
  ))
  
  # The follwing code renders and styles the data table tab.
  output$table2 <- renderDataTable({
    membrane_data = read.xlsx2("data/IL_Robeson_R.xlsx", 2)
    # The following lines remove unecessary metadata for the data tab.
    membrane_data = subset(
      membrane_data,
      select = -c(
        Type_cond,
        Material.1,
        Material.2,
        Material.3,
        Material.4,
        Material.5,
        Material.6,
        Notes,
        Institutions,
        Corresponding.Author,
        Corresponding.Author.Email,
        Corresponding.Author.Institution,
        P.CO2..Error,
        alphErr,
        J_abb,
        Page,
        Volume
      )
    )
    membrane_data = membrane_data[c(
      "Full.Name",
      "Abbreviation",
      "Type",
      "P",
      "alph",
      "IL.Cation.name",
      "IL.Cation.SMILE",
      "IL.Anion.name",
      "IL.Anion.SMILE",
      "PIL.Monomer.Cation.name",
      "PIL.Monomer.Cation.SMILE",
      "PIL.Anion.name",
      "PIL.Anion.SMILE",
      "Support.Copolymer.metal.organic.framework..MOF.",
      "Temperatures..degC.",
      "Pressures..bar.",
      "Year",
      "Article.Title",
      "Authors",
      "Journal",
      "DOI.URL"
    )]
  }, filter = 'top',
  extensions = c("Buttons", "Select"),
  selection = 'none',
  server = FALSE,
  colnames = c(
    "Full Name" = "Full.Name",
    "Permeability (Barrer)" = "P",
    "Selectivity" = "alph",
    "IL Cation Name" = "IL.Cation.name",
    "IL Cation SMILE" = "IL.Cation.SMILE",
    "IL Anion Name" = "IL.Anion.name",
    "IL Anion SMILE" = "IL.Anion.SMILE",
    "PIL Monomer Cation Name" = "PIL.Monomer.Cation.name",
    "PIL Monomer Cation SMILE" = "PIL.Monomer.Cation.SMILE",
    "PIL Anion Name" = "PIL.Anion.name",
    "PIL Anion SMILE" = "PIL.Anion.SMILE",
    "Other Materials" = "Support.Copolymer.metal.organic.framework..MOF.",
    "Temperature (DegC)" = "Temperatures..degC.",
    "Pressure (bar)" = "Pressures..bar.",
    "Article Title" = "Article.Title",
    "DOI Link" = "DOI.URL"
  ),
  callback = JS(
    "table.on('click.dt', 'td', function() {
            var row_=table.cell(this).index().row;
            var col=table.cell(this).index().column;
            var rnd= Math.random();
            var data = [row_, col, rnd];
           Shiny.onInputChange('rows2',data );
    });"
  ),
  options = list(
    select = TRUE,
    dom = "Blfrtip",
    scrollX = TRUE,
    autoWidth = TRUE,
    buttons = list(list(
      extend = "copy",
      text = 'Copy',
      exportOptions = list(modifier = list(selected = TRUE))
    )),
    # The columnDefs are used to control the size and format of the columns.
    columnDefs = list(
      list(width = '300px', targets = c(1, 2, 18, 19, 20)),
      list(
        width = '475px',
        targets = c(6, 7, 8, 9, 10, 11, 12, 13, 14)
      ),
      list(width = '100px', targets = c(3)),
      list(
        targets = c(1, 2, 18, 19, 20),
        render = JS(
          "function(data, type, row, meta) {",
          "return type === 'display' && data.length > 50 ?",
          "'<span title=\"' + data + '\">' + data.substr(0, 40) + '...</span>' : data;",
          "}"
        )
      ),
      list(
        targets = c(6, 7, 8, 9, 10, 11, 12, 13, 14),
        render = JS(
          "function(data, type, row, meta) {",
          "return type === 'display' && data.length > 70 ?",
          "'<span title=\"' + data + '\">' + data.substr(0, 60) + '...</span>' : data;",
          "}"
        )
      )
    )
  ))
  
  # The following code renders the plotly plot using the plot_builder function.
  output$plot1 <- renderPlotly({
    plot_builder(
      membrane_data = read.xlsx2("data/IL_Robeson_R.xlsx", 1),
      plot_src = "co2_n2_plot",
      # The following arguments are linked to inputs from widgets introduced in the UI part.
      minP = input$perm[1],
      maxP = input$perm[2],
      minAlph = input$alpha[1],
      maxAlph = input$alpha[2],
      minYr = input$yr[1],
      maxYr = input$yr[2],
      jour = input$jour,
      auth = input$auth,
      cati = input$cati,
      ani = input$ani,
      typs = input$typ
    )
  })
  
  # The following code looks for any marker click event and runs a pop-up window
  # which gives more information about the points clicked.
  observe({
    membrane_data = read.xlsx2("data/IL_Robeson_R.xlsx", 1)
    membrane_data$key <- row.names(membrane_data)
    # Setting the clicked variable equal to user input from any point clicks.
    clicked <-
      # The event_data fuction needs a first argument to specify what kind of
      # event to look for. It also is reccommended to link it to a source plot,
      # so that it would not mix a click in one plot with the other and shows
      # the wrong pop-up window.
      event_data("plotly_click", source = "co2_n2_plot", priority = "event")
    # Setting up the rowClicked variable equal to the key of the clicked point.
    rowClicked <- as.numeric(clicked$key)
    
    # The sweet alert (or pop-up window) will only show when "clicked" is not NULL.
    # This gurantees the sweet alert will not pop up randomly.
    if (!is.null(isolate(clicked))) {
      # sendSweetAlert is a function from shinyWidgets, which sends a pop up window
      # that can be formatted in html.
      sendSweetAlert(
        session = session,
        title = NULL,
        # withTags function makes using html tags a lot easier in shiny.
        text = withTags(
          div(
            class = "myclass",
            h1("About this Membrane"),
            p(small(
              b("Abbreviation: "),
              paste(membrane_data$Abbreviation[rowClicked])
            )),
            p(small(
              b("Full Name: "), paste(membrane_data$Full.Name[rowClicked])
            )),
            p(small(
              b("Type: "), paste(membrane_data$Type[rowClicked])
            )),
            br(),
            p(small(
              b("Permeability: "),
              paste(membrane_data$P[rowClicked]),
              paste("Barrer"),
              HTML(
                "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"
              ),
              b("Selectivity: "),
              paste(membrane_data$alph[rowClicked])
            )),
            br(),
            table(
              HTML(
                # The conditional_window is the function used to show alerts specific to
                # which point was clicked according to the type.
                # It baiscally prints a table with html tags according to the clicked point.
                conditional_window(membrane_data = membrane_data, rowClicked = rowClicked)
              ),
              cellpadding = "10px",
              cellspacing = "15px"
            ),
            p(small(
              b("Citation: "),
              small(
                paste(
                  membrane_data$Authors[rowClicked],
                  " ",
                  paste(membrane_data$Article.Title[rowClicked])
                ),
                ". ",
                i(paste(membrane_data$J_abb[rowClicked])),
                " ",
                b(paste(membrane_data$Year[rowClicked])),
                ", ",
                i(paste(membrane_data$Volume[rowClicked])),
                ", ",
                paste(membrane_data$Page[rowClicked]),
                "."
              )
            )),
            p(small(
              b("DOI: "),
              a(href = membrane_data$DOI.URL[rowClicked], membrane_data$DOI.URL[rowClicked])
            )),
            br(),
            p(
              small(
                b("Corresponding Author Instiution: "),
                membrane_data$Corresponding.Author.Institution[rowClicked]
              )
            )
          )
        ),
        type = "NONE",
        html = TRUE,
        width = "1500px"
        
      )
    }
    
    
  })
  
  # The following code is similar to the renderPlotly above, but for a different data
  # and will be used in a different tab.
  output$plot2 <- renderPlotly({
    plot_builder(
      membrane_data = read.xlsx2("data/IL_Robeson_R.xlsx", 2),
      plot_src = "co2_ch4_plot",
      minP = input$perm2[1],
      maxP = input$perm2[2],
      minAlph = input$alpha2[1],
      maxAlph = input$alpha2[2],
      minYr = input$yr2[1],
      maxYr = input$yr2[2],
      jour = input$jour2,
      auth = input$auth2,
      cati = input$cati2,
      ani = input$ani2,
      typs = input$typ2
    )
  })
  
  
  # The following code is similar to the observe function above, but to observe only the
  # second plot.
  observe({
    membrane_data = read.xlsx2("data/IL_Robeson_R.xlsx", 2)
    membrane_data$key <- row.names(membrane_data)
    clicked <-
      event_data("plotly_click", source = "co2_ch4_plot", priority = "event")
    rowClicked <- as.numeric(clicked$key)
    
    if (!is.null(isolate(clicked))) {
      sendSweetAlert(
        session = session,
        title = NULL,
        text = withTags(
          div(
            class = "myclass",
            h1("About this Membrane"),
            p(small(
              b("Abbreviation: "),
              paste(membrane_data$Abbreviation[rowClicked])
            )),
            p(small(
              b("Full Name: "), paste(membrane_data$Full.Name[rowClicked])
            )),
            p(small(
              b("Type: "), paste(membrane_data$Type[rowClicked])
            )),
            br(),
            p(small(
              b("Permeability: "),
              paste(membrane_data$P[rowClicked]),
              paste("Barrer"),
              HTML(
                "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"
              ),
              b("Selectivity: "),
              paste(membrane_data$alph[rowClicked])
            )),
            br(),
            table(
              HTML(
                conditional_window(membrane_data = membrane_data, rowClicked = rowClicked)
              ),
              cellpadding = "10px",
              cellspacing = "15px"
            ),
            
            p(small(
              b("Citation: "),
              small(
                paste(
                  membrane_data$Authors[rowClicked],
                  " ",
                  paste(membrane_data$Article.Title[rowClicked])
                ),
                ". ",
                i(paste(membrane_data$J_abb[rowClicked])),
                " ",
                b(paste(membrane_data$Year[rowClicked])),
                ", ",
                i(paste(membrane_data$Volume[rowClicked])),
                ", ",
                paste(membrane_data$Page[rowClicked]),
                "."
              )
            )),
            p(small(
              b("DOI: "),
              a(href = membrane_data$DOI.URL[rowClicked], membrane_data$DOI.URL[rowClicked])
            )),
            br(),
            p(
              small(
                b("Corresponding Author Instiution: "),
                membrane_data$Corresponding.Author.Institution[rowClicked]
              )
            )
          )
        ),
        type = "NONE",
        html = TRUE,
        width = "1500px"
        
      )
    }
    
    
  })
  # The following observe event check (only once) whether a user hovered on a point in the plotly plot
  # then send a toastr notification as a tutorial for what more can be done.
  observeEvent(event_data("plotly_hover", source = "co2_n2_plot", priority = "event"),
               once = TRUE,
               {
                 toastr_info("Click on the point for more information")
                 toastr_info("Click on the gear sympol for filters")
               })
  observeEvent(event_data("plotly_hover", source = "co2_ch4_plot", priority = "event"),
               once = TRUE,
               {
                 toastr_info("Click on the point for more information")
                 toastr_info("Click on the gear sympol for filters")
               })
  # the following observe events checks (only once) whether a user clicked on a row
  # in data tables then sends a toastr notification as a tutorial for what more can be done.
  observeEvent(input$rows1, once = TRUE, {
    toastr_info("Click on the copy button to copy to clipboard")
    toastr_info("Use ctrl + click (cmd + click for Mac) to select multiple rows")
  })
  observeEvent(input$rows2, once = TRUE, {
    toastr_info("Click on the copy button to copy to clipboard")
    toastr_info("Use ctrl + click (cmd + click for Mac) to select multiple rows")
  })
  
  # The following observe events are are used for the slider/box input
  # workaround widget. It requires 4 observeEven functions for each widget.
  # I will try to find another way to ensure a neater code.
  observeEvent(input$perm, {
    updateNumericInput(session, "perm_min", value = input$perm[1])
  })
  observeEvent(input$perm, {
    updateNumericInput(session, "perm_max", value = input$perm[2])
  })
  observeEvent(input$perm_max, {
    updateSliderInput(session, "perm",
                      value = c(input$perm[1], input$perm_max))
  })
  observeEvent(input$perm_min, {
    updateSliderInput(session, "perm",
                      value = c(input$perm_min, input$perm[2]))
  })
  
  observeEvent(input$alpha, {
    updateNumericInput(session, "alpha_min", value = input$alpha[1])
  })
  observeEvent(input$alpha, {
    updateNumericInput(session, "alpha_max", value = input$alpha[2])
  })
  observeEvent(input$alpha_max, {
    updateSliderInput(session, "alpha",
                      value = c(input$alpha[1], input$alpha_max))
  })
  observeEvent(input$alpha_min, {
    updateSliderInput(session, "alpha",
                      value = c(input$alpha_min, input$alpha[2]))
  })
  
  observeEvent(input$yr, {
    updateNumericInput(session, "yr_min", value = input$yr[1])
  })
  observeEvent(input$yr, {
    updateNumericInput(session, "yr_max", value = input$yr[2])
  })
  observeEvent(input$yr_max, {
    updateSliderInput(session, "yr",
                      value = c(input$yr[1], input$yr_max))
  })
  observeEvent(input$yr_min, {
    updateSliderInput(session, "yr",
                      value = c(input$yr_min, input$yr[2]))
  })
  
  observeEvent(input$perm2, {
    updateNumericInput(session, "perm2_min", value = input$perm2[1])
  })
  observeEvent(input$perm2, {
    updateNumericInput(session, "perm2_max", value = input$perm2[2])
  })
  observeEvent(input$perm2_max, {
    updateSliderInput(session, "perm2",
                      value = c(input$perm2[1], input$perm2_max))
  })
  observeEvent(input$perm2_min, {
    updateSliderInput(session, "perm2",
                      value = c(input$perm2_min, input$perm2[2]))
  })
  
  observeEvent(input$alpha2, {
    updateNumericInput(session, "alpha2_min", value = input$alpha2[1])
  })
  observeEvent(input$alpha2, {
    updateNumericInput(session, "alpha2_max", value = input$alpha2[2])
  })
  observeEvent(input$alpha2_max, {
    updateSliderInput(session,
                      "alpha2",
                      value = c(input$alpha2[1], input$alpha2_max))
  })
  observeEvent(input$alpha2_min, {
    updateSliderInput(session,
                      "alpha2",
                      value = c(input$alpha2_min, input$alpha2[2]))
  })
  
  observeEvent(input$yr2, {
    updateNumericInput(session, "yr2_min", value = input$yr2[1])
  })
  observeEvent(input$yr2, {
    updateNumericInput(session, "yr2_max", value = input$yr2[2])
  })
  observeEvent(input$yr2_max, {
    updateSliderInput(session, "yr2",
                      value = c(input$yr2[1], input$yr2_max))
  })
  observeEvent(input$yr2_min, {
    updateSliderInput(session, "yr2",
                      value = c(input$yr2_min, input$yr2[2]))
  })
  
  # The following observeEvents are for the reset buttons.
  observeEvent(input$res, {
    membrane_data <-
      read.xlsx2("data/IL_Robeson_R.xlsx", 1)
    # The updateSliderInput, updatePickerInput, and updateSwitchInput are used
    # to change the widgets serverside.
    updateSliderInput(
      session,
      "alpha",
      value = c(0, membrane_data$alph %>% as.vector %>% as.numeric %>% max)
    )
    updateSliderInput(session,
                      "perm",
                      value = c(0, membrane_data$P %>% as.vector %>% as.numeric %>% max))
    updateSliderInput(
      session,
      "yr",
      value = c(
        membrane_data$Year %>% as.vector %>% as.numeric %>% min,
        membrane_data$Year %>% as.vector %>% as.numeric %>% max
      )
    )
    
    updatePickerInput(
      session,
      inputId = "jour",
      label = "Journals",
      choices = as.character(unique(membrane_data$Journal))
    )
    
    updatePickerInput(
      session,
      inputId = "auth",
      label = "Author",
      choices = as.character(unique(membrane_data$Corresponding.Author))
    )
    
    updatePickerInput(
      session,
      inputId = "cati",
      label = "Cation",
      choices = c(as.character(
        unique(membrane_data$IL.Cation.name)
      ), as.character(
        unique(membrane_data$PIL.Monomer.Cation.name)
      ))[!c(as.character(unique(membrane_data$IL.Cation.name)), as.character(unique(
        membrane_data$PIL.Monomer.Cation.name
      ))) %in% c("", "-")]
    )
    
    updatePickerInput(
      session,
      inputId = "ani",
      label = "Anion",
      choices = c(as.character(
        unique(membrane_data$IL.Anion.name)
      ), as.character(
        unique(membrane_data$PIL.Anion.name)
      ))[!c(as.character(unique(membrane_data$IL.Anion.name)), as.character(unique(membrane_data$PIL.Anion.name))) %in% c("", "-")]
    )
    
    updateSwitchInput(session,
                      "typ",
                      label = "Color Types",
                      value = FALSE)

  })
  
  # The following observeEvents are for the reset buttons.
  observeEvent(input$res2, {
    membrane_data2 <-
      read.xlsx2("data/IL_Robeson_R.xlsx", 2)
    # The updateSliderInput, updatePickerInput, and updateSwitchInput are used
    # to change the widgets serverside.
    updateSliderInput(
      session,
      "alpha2",
      value = c(0, membrane_data2$alph %>% as.vector %>% as.numeric %>% max)
    )
    updateSliderInput(session,
                      "perm2",
                      value = c(0, membrane_data2$P %>% as.vector %>% as.numeric %>% max))
    updateSliderInput(
      session,
      "yr2",
      value = c(
        membrane_data2$Year %>% as.vector %>% as.numeric %>% min,
        membrane_data2$Year %>% as.vector %>% as.numeric %>% max
      )
    )
    
    updatePickerInput(
      session,
      inputId = "jour2",
      label = "Journals",
      choices = as.character(unique(membrane_data2$Journal))
    )
    
    updatePickerInput(
      session,
      inputId = "auth2",
      label = "Author",
      choices = as.character(unique(membrane_data2$Corresponding.Author))
    )
    
    updatePickerInput(
      session,
      inputId = "cati2",
      label = "Cation",
      choices = c(as.character(
        unique(membrane_data2$IL.Cation.name)
      ), as.character(
        unique(membrane_data2$PIL.Monomer.Cation.name)
      ))[!c(as.character(unique(membrane_data2$IL.Cation.name)), as.character(unique(
        membrane_data2$PIL.Monomer.Cation.name
      ))) %in% c("", "-")]
    )
    
    updatePickerInput(
      session,
      inputId = "ani2",
      label = "Anion",
      choices = c(as.character(
        unique(membrane_data2$IL.Anion.name)
      ), as.character(
        unique(membrane_data2$PIL.Anion.name)
      ))[!c(as.character(unique(membrane_data2$IL.Anion.name)), as.character(unique(membrane_data2$PIL.Anion.name))) %in% c("", "-")]
    )
    
    updateSwitchInput(session,
                      "typ2",
                      label = "Color Types",
                      value = FALSE)
    
  })
}