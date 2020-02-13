# This script is for the server part of the web app.
# Here UI objects are linked with inputs or outputs.

server <- function(input, output, session) {
  # sourcing the functions to be used here.
  source('plot_builder.R')
  source('conditional_window.R')
  # The follwing code renders and styles the data table tab.
  output$table1 <- DT::renderDataTable({
    membrane_data = read.xlsx2("data/IL_Robeson_R.xlsx", 1)
  }, filter = 'top',
  options = list(
    pageLength = 10,
    scrollX = TRUE,
    autoWidth = TRUE,
    columnDefs = list(list(width = '100px', targets = 2))
  ))
  
  # The follwing code renders and styles the data table tab.
  output$table2 <- DT::renderDataTable({
    membrane_data = read.xlsx2("data/IL_Robeson_R.xlsx", 2)
  }, filter = 'top',
  options = list(
    pageLength = 10,
    scrollX = TRUE,
    autoWidth = TRUE,
    columnDefs = list(list(width = '100px', targets = 2))
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
            p(small(
              b("Corresponding Author: "),
              membrane_data$Corresponding.Author[rowClicked]
            )),
            p(
              small(
                b("Corresponding Author Instiution: "),
                membrane_data$Corresponding.Author.Institution[rowClicked]
              )
            ),
            p(small(
              b("Corresponding Author Email: "),
              a(membrane_data$Corresponding.Author.Email[rowClicked])
            ))
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
            p(small(
              b("Corresponding Author: "),
              membrane_data$Corresponding.Author[rowClicked]
            )),
            p(
              small(
                b("Corresponding Author Instiution: "),
                membrane_data$Corresponding.Author.Institution[rowClicked]
              )
            ),
            p(small(
              b("Corresponding Author Email: "),
              a(membrane_data$Corresponding.Author.Email[rowClicked])
            ))
          )
        ),
        type = "NONE",
        html = TRUE,
        width = "1500px"
        
      )
    }
    
    
  })
  
  
}