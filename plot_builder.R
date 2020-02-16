# This script is for the plot_builder function.
# This function  takes a number of argument that are user inputs from widgets
# and tweaks the plot_ly function accordingly.

# It is important to note that, for filter widgets, this fundtion actually removes datapoints
# excluded by the user from the database. Which means that plotly will need to
# make the plot again, but with the modified database.
# For example, if the user used the slider widget to view only membranes with permeability
# between 20-100, this function will delete anything above or below that from the database.
# Then it will ask plotly to make the plate again with the modified database.

plot_builder <- function(membrane_data,
                         # The plot_srce argument is required, and this is important to tell
                         # the function which database to use (CO2/N2 or CO2/CH4).
                         plot_src,
                         # maxAlph and minAlph are manipulated through user input, but as
                         # default they go from 0 to maximum selectivity.
                         maxAlph = membrane_data$alph %>% as.vector %>% as.numeric %>% max,
                         minAlph = 0,
                         # maxP and minP are manipulated through user input, but as
                         # default they go from 0 to maximum permeability.
                         maxP = membrane_data$P %>% as.vector %>% as.numeric %>% max,
                         minP = 0,
                         # maxYr and minYr are manipulated through user input, but as
                         # default they go from minimum years to maximum years.
                         maxYr = membrane_data$Year %>% as.vector %>% as.numeric %>% max,
                         minYr = membrane_data$Year %>% as.vector %>% as.numeric %>% min,
                         # the following arguments are manipulated through user input. They
                         # are for filtering the journals, authors, materials (cation, anion)
                         # and type (this is a highlight/filter, and is filtered or highlighted
                         # natively in plotly rather than having to manipulate the database separately).
                         jour = NULL,
                         auth = NULL,
                         cati = NULL,
                         ani = NULL,
                         typs = NULL) {
  # The follwing if/else if statements check the plot_src argument to see which
  # data was chosen.
  if (plot_src == "co2_n2_plot") {
    membrane_data <-
      read.xlsx2("data/IL_Robeson_R.xlsx", 1)
  }
  else if (plot_src == "co2_ch4_plot") {
    membrane_data <-
      read.xlsx2("data/IL_Robeson_R.xlsx", 2)
  }
  
  # Introducing a new column "key", which will be used to refer to certain datapoints.
  # this simply adds a column of row numbers. This is useful when having to filter
  # datapoints out of the database. For example if the user filtered anything not between 20-100
  # permeability, the datapoints excluded will be removed, and the modified database
  # will assign the remaining data with new row number. Thus giving each row a key, then using
  # this key to refer to the row is better than using the row number as the point to refer to.
  membrane_data$key <- row.names(membrane_data)
  
  # The following code edits the Full Name column to add line breaks (</br>), which makes it
  # easier to make the tooltip smaller.
  # Note that I am going through the "levels" and not the entire column.
  # This is because it is easier to channge the "levels" (which is basically unique values of the column).
  
  for (i in 1:length(levels(membrane_data$Full.Name))) {
    # The strwrap function is useful in breaking the string into parts, then adding
    # prefixes to each part. temp_text will be a vector of strings.
    temp_text = strwrap(
      levels(membrane_data$Full.Name)[i],
      width = 100,
      indent = 0,
      exdent = 20,
      prefix = "</br>",
      simplify = TRUE,
      initial = ""
    )
    # Collapsing the temp_text vector into one string.
    temp_text = str_c(temp_text, collapse = "")
    # Replacing the new full name with the old.
    levels(membrane_data$Full.Name)[i] <- temp_text
  }
  
  # The following code removes any rows (from the database) with permeability values above or below
  # those chosen by the user, or the default if nothing was chosen by the user.
  record = numeric(0)
  if (!is_empty(membrane_data$P)) {
    for (i in 1:length(as.vector(membrane_data$P))) {
      if (as.numeric(as.vector(membrane_data$P[i])) > maxP) {
        record = c(record, i)
      }
      if (as.numeric(as.vector(membrane_data$P[i])) < minP) {
        record = c(record, i)
      }
    }
  }
  if (!is_empty(record)) {
    membrane_data = membrane_data[-c(record),]
  }
  
  # The following code removes any rows (from the database) with selectivity values above or below
  # those chosen by the user, or the default if nothing was chosen by the user.
  record = numeric(0)
  if (!is_empty(membrane_data$alph)) {
    for (i in 1:length(as.vector(membrane_data$alph))) {
      if (as.numeric(as.vector(membrane_data$alph[i])) > maxAlph) {
        record = c(record, i)
      }
      if (as.numeric(as.vector(membrane_data$alph[i])) < minAlph) {
        record = c(record, i)
      }
    }
  }
  if (is_empty(record) == F) {
    membrane_data = membrane_data[-c(record),]
  }
  
  # The following code removes any rows (from the database) with years values above or below
  # those chosen by the user, or the default if nothing was chosen by the user.
  record = numeric(0)
  if (!is_empty(membrane_data$Year)) {
    for (i in 1:length(as.vector(membrane_data$Year))) {
      if (as.numeric(as.vector(membrane_data$Year[i])) > as.numeric(maxYr)) {
        record = c(record, i)
      }
      if (as.numeric(as.vector(membrane_data$Year[i])) < as.numeric(minYr)) {
        record = c(record, i)
      }
    }
  }
  if (is_empty(record) == F) {
    membrane_data = membrane_data[-c(record),]
  }
  
  # The following code checks user input for journals, and only runs when neither the database
  # nor the user input is empty. It removes any row that is not in the user input. If all rows are
  # chosen it removes nothing. Also, if no rows were chosen, it will also remove nothing.
  # I did that beacuse as default I wanted the user input to be empty here, and also having to show
  # the plot with nothing deleted initially. Once the user starts selecting, stuff will be removed.
  record = numeric(0)
  if (!is_empty(membrane_data$Journal) && !is_empty(jour)) {
    for (i in 1:length(as.vector(membrane_data$Journal))) {
      if (!(as.character(as.vector(membrane_data$Journal[i])) %in% jour)) {
        record = c(record, i)
      }
    }
  }
  if (is_empty(record) == F) {
    membrane_data = membrane_data[-c(record),]
  }
  
  # Similar to the journal filter, the following code will filter any row with authors
  # not chosen by the user. Here I only used the corresponding author.
  record = numeric(0)
  if (!is_empty(membrane_data$Corresponding.Author) && !is_empty(auth)) {
    for (i in 1:length(as.vector(membrane_data$Corresponding.Author))) {
      if (!(as.character(as.vector(membrane_data$Corresponding.Author[i])) %in% auth)) {
        record = c(record, i)
      }
    }
  }
  if (is_empty(record) == F) {
    membrane_data = membrane_data[-c(record),]
  }
  
  # Similar to the journal filter, the following code will filter any row with cations
  # not chosen by the user. This is a bit more complicated and required a little logical
  # workaround to get it to filter ploymeric cations as well as non-polymeric one,
  # because they are held in a different row in the database.
  record = numeric(0)
  if ((!is_empty(membrane_data$IL.Cation.name)) &&
      !is_empty(cati)) {
    for (i in 1:length(as.vector(membrane_data$IL.Cation.name))) {
      if (!(as.character(as.vector(membrane_data$IL.Cation.name[i])) %in% cati) &&
          (as.character(as.vector(membrane_data$Type_cond[i])) %in% c("SILM", "MMM", "Polymer-IL", "No IL Membrane"))) {
        record = c(record, i)
      }
      if (!(as.character(as.vector(
        membrane_data$PIL.Monomer.Cation.name[i]
      )) %in% cati) &&
      (as.character(as.vector(membrane_data$Type_cond[i])) %in% c("PIL-BCP", "PIL", "No IL Membrane"))) {
        record = c(record, i)
      }
      if ((!(as.character(
        as.vector(membrane_data$PIL.Monomer.Cation.name[i])
      ) %in% cati) &&
      !(as.character(
        as.vector(membrane_data$IL.Cation.name[i])
      ) %in% cati)) &&
      (
        as.character(as.vector(membrane_data$Type_cond[i])) %in% c("MMM (PIL)", "PIL-BCP (free IL)", "PIL-IL", "No IL Membrane")
      )) {
        record = c(record, i)
      }
    }
  }
  if (is_empty(record) == F) {
    membrane_data = membrane_data[-c(record),]
  }
  
  # This is similar to the cation filter, just does the same with anions.
  record = numeric(0)
  if ((!is_empty(membrane_data$IL.Anion.name)) && !is_empty(ani)) {
    for (i in 1:length(as.vector(membrane_data$IL.Anion.name))) {
      if (!(as.character(as.vector(membrane_data$IL.Anion.name[i])) %in% ani) &&
          (as.character(as.vector(membrane_data$Type_cond[i])) %in% c("SILM", "MMM", "Polymer-IL", "No IL Membrane"))) {
        record = c(record, i)
      }
      if (!(as.character(as.vector(membrane_data$PIL.Anion.name[i])) %in% ani) &&
          (as.character(as.vector(membrane_data$Type_cond[i])) %in% c("PIL-BCP", "PIL", "No IL Membrane"))) {
        record = c(record, i)
      }
      if ((!(as.character(
        as.vector(membrane_data$PIL.Anion.name[i])
      ) %in% ani) &&
      !(as.character(
        as.vector(membrane_data$IL.Anion.name[i])
      ) %in% ani)) &&
      (
        as.character(as.vector(membrane_data$Type_cond[i])) %in% c("MMM (PIL)", "PIL-BCP (free IL)", "PIL-IL", "No IL Membrane")
      )) {
        record = c(record, i)
      }
    }
  }
  if (is_empty(record) == F) {
    membrane_data = membrane_data[-c(record),]
  }
  
  # The following code check if the type switch was used, then sets two variables
  # equal to arguments to be used im the plot_ly function to change the color and add
  # a legend only when the type switch widget is on.
  if (typs == TRUE) {
    tr <- membrane_data$Type
    l <- list(
      legendgroup = membrane_data$Type,
      font = list(
        family = "sans-serif",
        size = 12,
        color = "#000"
      ),
      bgcolor = "#E2E2E2",
      bordercolor = "black",
      borderwidth = 2,
      x = 0.9,
      y = 0.9,
      traceorder = "reversed"
    )
  } else {
    tr = NULL
    l = NULL
  }
  
  # The following variables are set as lists to format the axes style and font.
  f1 <- list(family = "Arial, sans-serif",
             size = 18,
             color = "lightgrey")
  f2 <- list(family = "Old Standard TT, serif",
             size = 14,
             color = "black")
  x_axis <- list(
    title = "Permeability",
    titlefont = f1,
    showticklabels = TRUE,
    tickangle = 45,
    tickfont = f2,
    exponentformat = "E",
    type = "log"
  )
  y_axis <- list(
    title = "Selectivity",
    titlefont = f1,
    showticklabels = TRUE,
    tickangle = 45,
    tickfont = f2,
    exponentformat = "E",
    type = "log"
  )
  
  # The following function is the plot_ly function, which makes the plot.
  plot_ly(
    # Instructs the function to use the membrane_data database.
    data = membrane_data,
    # Sets its type as scatter.
    type = "scatter",
    # Sets the x an y axes.
    x = as.numeric(as.vector(membrane_data$P)),
    y = as.numeric(as.vector(membrane_data$alph)),
    # Turn the hoverinfo (tooltip) as 'text', which is shown below.
    hoverinfo = 'text',
    # Instructs the function to change marker colors according to the type.
    color = tr,
    # The key argument is set as equal to the key column in the database.
    # This will be important with the marker click event.
    key = ~ key,
    # Naming the source of this plot according to the plot_src input.
    # This will be important with the marker click event.
    source = plot_src,
    # The following text is done conditionally, and will be used in the tooltip.
    # This means that each type will get a different tooltip view.
    text =
      ifelse(
        as.vector(membrane_data$Type_cond) == 'PIL-BCP',
        paste(
          '<b>Full Name:</br></br></b>',
          as.vector(membrane_data$Full.Name),
          '</br><b>Type:</b> ',
          as.vector(membrane_data$Type),
          '</br></br><b>Permeability:</b> ',
          as.vector(membrane_data$P),
          '</br><b>Selectivity:</b> ',
          as.vector(membrane_data$alph),
          '</br></br><b>Copolymer:</br></b>',
          as.vector(
            membrane_data$Support.Copolymer.metal.organic.framework..MOF.
          ),
          '</br><b>PIL Cation Monomer:</b> ',
          as.vector(membrane_data$PIL.Monomer.Cation.name),
          '</br><b>PIL Anion:</b> ',
          as.vector(membrane_data$PIL.Anion.name)
        ),
        ifelse(
          as.vector(membrane_data$Type_cond) == 'SILM',
          paste(
            '<b>Full Name:</br></br></b>',
            as.vector(membrane_data$Full.Name),
            '</br><b>Type:</b> ',
            as.vector(membrane_data$Type),
            '</br></br><b>Permeability:</b> ',
            as.vector(membrane_data$P),
            '</br><b>Selectivity:</b> ',
            as.vector(membrane_data$alph),
            '</br></br><b>Support:</br></b>',
            as.vector(
              membrane_data$Support.Copolymer.metal.organic.framework..MOF.
            ),
            '</br><b>IL Cation:</b> ',
            as.vector(membrane_data$IL.Cation.name),
            '</br><b>IL Anion :</b> ',
            as.vector(membrane_data$IL.Anion.name)
          ),
          ifelse(
            as.vector(membrane_data$Type_cond) == 'PIL',
            paste(
              '<b>Full Name:</br></br></b>',
              as.vector(membrane_data$Full.Name),
              '</br><b>Type:</b> ',
              as.vector(membrane_data$Type),
              '</br></br><b>Permeability:</b> ',
              as.vector(membrane_data$P),
              '</br><b>Selectivity:</b> ',
              as.vector(membrane_data$alph),
              '</br></br><b>PIL Cation Monomer:</b> ',
              as.vector(membrane_data$PIL.Monomer.Cation.name),
              '</br><b>PIL Anion:</b> ',
              as.vector(membrane_data$PIL.Anion.name)
            ),
            ifelse(
              as.vector(membrane_data$Type_cond) == 'MMM',
              paste(
                '<b>Full Name:</br></br></b>',
                as.vector(membrane_data$Full.Name),
                '</br><b>Type:</b> ',
                as.vector(membrane_data$Type),
                '</br></br><b>Permeability:</b> ',
                as.vector(membrane_data$P),
                '</br><b>Selectivity:</b> ',
                as.vector(membrane_data$alph),
                '</br></br><b>MMM Component:</br></b>',
                as.vector(
                  membrane_data$Support.Copolymer.metal.organic.framework..MOF.
                ),
                '</br><b>IL Cation:</b> ',
                as.vector(membrane_data$IL.Cation.name),
                '</br><b>IL Anion :</b> ',
                as.vector(membrane_data$IL.Anion.name)
              ),
              ifelse(
                as.vector(membrane_data$Type_cond) == 'PIL-IL',
                paste(
                  '<b>Full Name:</br></br></b>',
                  as.vector(membrane_data$Full.Name),
                  '</br><b>Type:</b> ',
                  as.vector(membrane_data$Type),
                  '</br></br><b>Permeability:</b> ',
                  as.vector(membrane_data$P),
                  '</br><b>Selectivity:</b> ',
                  as.vector(membrane_data$alph),
                  '</br></br><b>PIL Cation Monomer:</b> ',
                  as.vector(membrane_data$PIL.Monomer.Cation.name),
                  '</br><b>PIL Anion:</b> ',
                  as.vector(membrane_data$PIL.Anion.name),
                  '</br><b>IL Cation:</b> ',
                  as.vector(membrane_data$IL.Cation.name),
                  '</br><b>IL Anion :</b> ',
                  as.vector(membrane_data$IL.Anion.name)
                ),
                ifelse(
                  as.vector(membrane_data$Type_cond) == 'PIL-BCP (free IL)',
                  paste(
                    '<b>Full Name:</br></br></b>',
                    as.vector(membrane_data$Full.Name),
                    '</br><b>Type:</b> ',
                    as.vector(membrane_data$Type),
                    '</br></br><b>Permeability:</b> ',
                    as.vector(membrane_data$P),
                    '</br><b>Selectivity:</b> ',
                    as.vector(membrane_data$alph),
                    '</br></br><b>Copolymer:</br></b>',
                    as.vector(
                      membrane_data$Support.Copolymer.metal.organic.framework..MOF.
                    ),
                    '</br><b>PIL Cation Monomer:</b> ',
                    as.vector(membrane_data$PIL.Monomer.Cation.name),
                    '</br><b>PIL Anion:</b> ',
                    as.vector(membrane_data$PIL.Anion.name),
                    '</br><b>IL Cation:</b> ',
                    as.vector(membrane_data$IL.Cation.name),
                    '</br><b>IL Anion :</b> ',
                    as.vector(membrane_data$IL.Anion.name)
                  ),
                  ifelse(
                    as.vector(membrane_data$Type_cond) == 'Polymer-IL',
                    paste(
                      '<b>Full Name:</br></br></b>',
                      as.vector(membrane_data$Full.Name),
                      '</br><b>Type:</b> ',
                      as.vector(membrane_data$Type),
                      '</br></br><b>Permeability:</b> ',
                      as.vector(membrane_data$P),
                      '</br><b>Selectivity:</b> ',
                      as.vector(membrane_data$alph),
                      '</br></br><b>Polymer:</br></b>',
                      as.vector(
                        membrane_data$Support.Copolymer.metal.organic.framework..MOF.
                      ),
                      '</br><b>IL Cation:</b> ',
                      as.vector(membrane_data$IL.Cation.name),
                      '</br><b>IL Cation SMILE:</b> ',
                      as.vector(membrane_data$IL.Anion.name)
                    ),
                    ifelse(
                      as.vector(membrane_data$Type_cond) == 'MMM (PIL)',
                      paste(
                        '<b>Full Name:</br></br></b>',
                        as.vector(membrane_data$Full.Name),
                        '</br><b>Type:</b> ',
                        as.vector(membrane_data$Type),
                        '</br></br><b>Permeability:</b> ',
                        as.vector(membrane_data$P),
                        '</br><b>Selectivity:</b> ',
                        as.vector(membrane_data$alph),
                        '</br></br><b>MMM Component:</br></b>',
                        as.vector(
                          membrane_data$Support.Copolymer.metal.organic.framework..MOF.
                        ),
                        '</br><b>PIL Cation Monomer:</b> ',
                        as.vector(membrane_data$PIL.Monomer.Cation.name),
                        '</br><b>PIL Cation Monomer SMILE:</b> ',
                        as.vector(membrane_data$PIL.Anion.name),
                        '</br><b>IL Cation:</b> ',
                        as.vector(membrane_data$IL.Cation.name),
                        '</br><b>IL Anion :</b> ',
                        as.vector(membrane_data$IL.Anion.name)
                      ),
                      ifelse(
                        as.vector(membrane_data$Type_cond) == 'No IL Membrane',
                        paste(
                          '<b>Full Name:</br></br></b>',
                          as.vector(membrane_data$Full.Name),
                          '</br><b>Type:</b> ',
                          as.vector(membrane_data$Type),
                          '</br></br><b>Permeability:</b> ',
                          as.vector(membrane_data$P),
                          '</br><b>Selectivity:</b> ',
                          as.vector(membrane_data$alph)
                        ),
                        paste('')
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
  )  %>%
    # The layout function is the parent function of the plot_ly function.
    # The %>% operator is used to pipe the plot_ly function in the layout function,
    # instead of doing: parentFunction(function).
    # It is used to style the plot_ly function.
    layout(yaxis = y_axis,
           xaxis = x_axis,
           legend = l)
  
}
