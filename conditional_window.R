# This script hold the conditional_window function.
# This function takes the database and the row clicked to give
# an html tagged table with the specific anion-cation description.
# This function also uses "https://cactus.nci.nih.gov/" api to translate
# SMILES to actual images.

conditional_window <- function(membrane_data, rowClicked = rowClicked) {
  # If the clicked on point has a type equal to the string do the following.
  # For Polymeric Ionic Liquid - Copolymer, the table in the pop-up window should show:
  # The copolymer name, PIL monomer cation and anion names and structures.
  if (as.vector(membrane_data$Type_cond[rowClicked]) == 'PIL-BCP') {
    paste(
      tags$tr(tags$th(tags$p(
        "Copolymer", align = "center"
      )), tags$th(
        tags$p("PIL Monomer (Cation)", align = "center")
      ), tags$th(
        tags$p("PIL Monomer (Anion)", align = "center")
      )),
      tags$tr(tags$td(
        paste(
          membrane_data$Support.Copolymer.metal.organic.framework..MOF.[rowClicked]
        )
      ), tags$td(
        paste(membrane_data$PIL.Monomer.Cation.name[rowClicked])
      ), tags$td(
        paste(membrane_data$PIL.Anion.name[rowClicked])
      )),
      tags$tr(tags$td("-"),
              tags$td(
                tags$img(
                  src = paste(
                    "https://cactus.nci.nih.gov/chemical/structure/",
                    membrane_data$PIL.Monomer.Cation.SMILE[rowClicked],
                    "/image"
                  ),
                  width = "250px",
                  height = "250px"
                )
              ),
              tags$td(
                tags$img(
                  src = paste(
                    "https://cactus.nci.nih.gov/chemical/structure/",
                    membrane_data$PIL.Anion.SMILE[rowClicked],
                    "/image"
                  ),
                  width = "250px",
                  height = "250px"
                )
              ))
    )
  }
  # For Supported Ionic Liquid, the table in the pop-up window should show:
  # The support polymer name, IL monomer cation and anion names and structures.
  else if (as.vector(membrane_data$Type_cond[rowClicked]) == 'SILM') {
    paste(
      tags$tr(tags$th(tags$p(
        "Support", align = "center"
      )), tags$th(
        tags$p("IL (Cation)", align = "center")
      ), tags$th(tags$p(
        "IL (Anion)", align = "center"
      ))),
      tags$tr(tags$td(
        paste(
          membrane_data$Support.Copolymer.metal.organic.framework..MOF.[rowClicked]
        )
      ), tags$td(
        paste(membrane_data$IL.Cation.name[rowClicked])
      ), tags$td(
        paste(membrane_data$IL.Anion.name[rowClicked])
      )),
      tags$tr(tags$td("-"),
              tags$td(
                tags$img(
                  src = paste(
                    "https://cactus.nci.nih.gov/chemical/structure/",
                    membrane_data$IL.Cation.SMILE[rowClicked],
                    "/image"
                  ),
                  width = "250px",
                  height = "250px"
                )
              ),
              tags$td(
                tags$img(
                  src = paste(
                    "https://cactus.nci.nih.gov/chemical/structure/",
                    membrane_data$IL.Anion.SMILE[rowClicked],
                    "/image"
                  ),
                  width = "250px",
                  height = "250px"
                )
              ))
    )
  }
  # For Polymeric Ionic Liquid - Copolymer, the table in the pop-up window should show:
  # PIL monomer cation and anion names and structures.
  else if (as.vector(membrane_data$Type_cond[rowClicked]) == 'PIL') {
    paste(
      tags$tr(tags$th(
        tags$p("PIL Monomer (Cation)", align = "center")
      ), tags$th(
        tags$p("PIL Monomer (Anion)", align = "center")
      )),
      tags$tr(tags$td(
        paste(membrane_data$PIL.Monomer.Cation.name[rowClicked])
      ), tags$td(
        paste(membrane_data$PIL.Anion.name[rowClicked])
      )),
      tags$tr(tags$td(
        tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$PIL.Monomer.Cation.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )
      ),
      tags$td(
        tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$PIL.Anion.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )
      ))
    )
  }
  # For Mixed Matrix with IL, the table in the pop-up window should show:
  # The matrix component name, PIL monomer cation and anion names and structures.
  else if (as.vector(membrane_data$Type_cond[rowClicked]) == 'MMM') {
    paste(
      tags$tr(tags$th(
        tags$p("Matrix Component", align = "center")
      ), tags$th(
        tags$p("IL (Cation)", align = "center")
      ), tags$th(tags$p(
        "IL (Anion)", align = "center"
      ))),
      tags$tr(tags$td(
        paste(
          membrane_data$Support.Copolymer.metal.organic.framework..MOF.[rowClicked]
        )
      ), tags$td(
        paste(membrane_data$IL.Cation.name[rowClicked])
      ), tags$td(
        paste(membrane_data$IL.Anion.name[rowClicked])
      )),
      tags$tr(tags$td("-"),
              tags$td(
                tags$img(
                  src = paste(
                    "https://cactus.nci.nih.gov/chemical/structure/",
                    membrane_data$IL.Cation.SMILE[rowClicked],
                    "/image"
                  ),
                  width = "250px",
                  height = "250px"
                )
              ),
              tags$td(
                tags$img(
                  src = paste(
                    "https://cactus.nci.nih.gov/chemical/structure/",
                    membrane_data$IL.Anion.SMILE[rowClicked],
                    "/image"
                  ),
                  width = "250px",
                  height = "250px"
                )
              ))
    )
  }
  # For Polymeric Ionic Liquid - Free Ionic Liquid, the table in the pop-up window should show:
  # PIL monomer cation and anion names and structures, IL monomer cation and anion names and structures.
  else if (as.vector(membrane_data$Type_cond[rowClicked]) == 'PIL-IL') {
    paste(
      tags$tr(
        tags$th(tags$p("IL (Cation)", align = "center")),
        tags$th(tags$p("IL (Anion)", align = "center")),
        tags$th(tags$p("PIL Monomer (Cation)", align = "center")),
        tags$th(tags$p("PIL Monomer (Anion)", align = "center"))
      ),
      tags$tr(
        tags$td(paste(membrane_data$IL.Cation.name[rowClicked])),
        tags$td(paste(membrane_data$IL.Anion.name[rowClicked])),
        tags$td(paste(
          membrane_data$PIL.Monomer.Cation.name[rowClicked]
        )),
        tags$td(paste(membrane_data$PIL.Anion.name[rowClicked]))
      ),
      tags$tr(
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$IL.Cation.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$IL.Anion.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$PIL.Monomer.Cation.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$PIL.Anion.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        ))
      )
    )
  }
  # For Polymeric Ionic Liquid - Copolymer - Free Ionic Liquid, the table in the pop-up window should show:
  # The copolymer name, PIL monomer cation and anion names and structures, IL monomer cation and anion names and structures.
  else if (as.vector(membrane_data$Type_cond[rowClicked]) == 'PIL-BCP (free IL)') {
    paste(
      tags$tr(
        tags$th(tags$p("Copolymer", align = "center")),
        tags$th(tags$p("IL (Cation)", align = "center")),
        tags$th(tags$p("IL (Anion)", align = "center")),
        tags$th(tags$p("PIL Monomer (Cation)", align = "center")),
        tags$th(tags$p("PIL Monomer (Anion)", align = "center"))
      ),
      tags$tr(
        tags$td(
          paste(
            membrane_data$Support.Copolymer.metal.organic.framework..MOF.[rowClicked]
          )
        ),
        tags$td(paste(membrane_data$IL.Cation.name[rowClicked])),
        tags$td(paste(membrane_data$IL.Anion.name[rowClicked])),
        tags$td(paste(
          membrane_data$PIL.Monomer.Cation.name[rowClicked]
        )),
        tags$td(paste(membrane_data$PIL.Anion.name[rowClicked]))
      ),
      tags$tr(
        tags$td("-"),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$IL.Cation.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$IL.Anion.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$PIL.Monomer.Cation.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$PIL.Anion.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        ))
      )
    )
  }
  # For Polymer - Ionic Liquid gels, the table in the pop-up window should show:
  # Polymer name, IL monomer cation and anion names and structures.
  else if (as.vector(membrane_data$Type_cond[rowClicked]) == 'Polymer-IL') {
    paste(
      tags$tr(tags$th(tags$p(
        "Polymer", align = "center"
      )), tags$th(
        tags$p("IL (Cation)", align = "center")
      ), tags$th(tags$p(
        "IL (Anion)", align = "center"
      ))),
      tags$tr(tags$td(
        paste(
          membrane_data$Support.Copolymer.metal.organic.framework..MOF.[rowClicked]
        )
      ), tags$td(
        paste(membrane_data$IL.Cation.name[rowClicked])
      ), tags$td(
        paste(membrane_data$IL.Anion.name[rowClicked])
      )),
      tags$tr(tags$td("-"),
              tags$td(
                tags$img(
                  src = paste(
                    "https://cactus.nci.nih.gov/chemical/structure/",
                    membrane_data$IL.Cation.SMILE[rowClicked],
                    "/image"
                  ),
                  width = "250px",
                  height = "250px"
                )
              ),
              tags$td(
                tags$img(
                  src = paste(
                    "https://cactus.nci.nih.gov/chemical/structure/",
                    membrane_data$IL.Anion.SMILE[rowClicked],
                    "/image"
                  ),
                  width = "250px",
                  height = "250px"
                )
              ))
    )
  }
  # For Mixed Matrix with PIL and free IL, the table in the pop-up window should show:
  # The matrix component name, PIL monomer cation and anion names and structures, IL monomer cation and anion names and structures.
  else if (as.vector(membrane_data$Type_cond[rowClicked]) == 'MMM (PIL)') {
    paste(
      tags$tr(
        tags$th(tags$p("Matrix Component", align = "center")),
        tags$th(tags$p("IL (Cation)", align = "center")),
        tags$th(tags$p("IL (Anion)", align = "center")),
        tags$th(tags$p("PIL Monomer (Cation)", align = "center")),
        tags$th(tags$p("PIL Monomer (Anion)", align = "center"))
      ),
      tags$tr(
        tags$td(
          paste(
            membrane_data$Support.Copolymer.metal.organic.framework..MOF.[rowClicked]
          )
        ),
        tags$td(paste(membrane_data$IL.Cation.name[rowClicked])),
        tags$td(paste(membrane_data$IL.Anion.name[rowClicked])),
        tags$td(paste(
          membrane_data$PIL.Monomer.Cation.name[rowClicked]
        )),
        tags$td(paste(membrane_data$PIL.Anion.name[rowClicked]))
      ),
      tags$tr(
        tags$td("-"),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$IL.Cation.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$IL.Anion.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$PIL.Monomer.Cation.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        )),
        tags$td(tags$img(
          src = paste(
            "https://cactus.nci.nih.gov/chemical/structure/",
            membrane_data$PIL.Anion.SMILE[rowClicked],
            "/image"
          ),
          width = "250px",
          height = "250px"
        ))
      )
    )
  }
  # If no IL, keep table empty.
  else if (as.vector(membrane_data$Type_cond[rowClicked]) == 'No IL Membrane') {
    
  }
}
