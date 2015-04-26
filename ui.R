library(shiny)
shinyUI(navbarPage("Wine Quality Estimator",
                   tabPanel("Introduction",
                            fluidPage(
                              fluidRow(
                                  column(width = 3,align="center",
                                         br(),
                                         img(src="redwine.png", width=152,height=212),
                                         br(),br(),br(),br(),
                                         img(src="logo.jpg", width=160,height=160)
                                  ),
                                  column(9,
                                         h3("Introduction"),
                                       p(strong("The purpose of this tool is to estimate the quality of a wine based on its physicochemical properties.")),
                                    
                                        p('The estimation is made based on a dataset of 1599 red wines "Vinho Verde" (from Portugal).',br(),
                                          'Each wine has taken a set of objectives tests (e.g. pH value) and was evaluated by at least 3 wine experts. Each expert graded the wine quality 
  between 0 (very poor) and 10 (very excellent), then median of the evaluations was taken to classify each wine.',
                                          br(),
                                          'Therefore this tool must be used to estimate',strong('only red wine "Vinho Verde".')),
                                       h3("User guide"),
                                       p('1. Go to the tab "Estimator"',
                                         br(),
                                         '2. Select values for each property on the left-side panel',
                                         br(),
                                         '(you can visualize at the same time, on the right-side panel, the position of your wine compared to others from the dataset)',
                                         br(),
                                         '3. Press the button "Estimate", to get the estimated quality of your wine in the bottom right-side panel.'),
                                         
                                       
                                              
                                                fluidRow(
                                                  column(width = 8,
                                                         h3("Information about the dataset"),
                                                         "Thank you to following people for their public datasets and their research:",
                                                         br(),
                                                         "P. Cortez, A. Cerdeira, F. Almeida, T. Matos and J. Reis.",
                                                         br(),
                                                         "Modeling wine preferences by data mining from physicochemical properties.",
                                                         br(),
                                                         "In Decision Support Systems>, Elsevier, 47(4):547-553. ISSN: 0167-9236.",
                                                         br(),
                                                         "Available at:",
                                                         a("[@Elsevier]", href = "http://dx.doi.org/10.1016/j.dss.2009.05.016"),
                                                         ", ", 
                                                         a("[Pre-press (pdf)]", href = "http://www3.dsi.uminho.pt/pcortez/winequality09.pdf"),
                                                         ", ", 
                                                         a("[bib]", href = "http://www3.dsi.uminho.pt/pcortez/dss09.bib"),
                                                         " and ",
                                                         a("[Dataset]",href="https://archive.ics.uci.edu/ml/datasets/Wine+Quality")
                                                   ),
                                                  column(width = 4,align="center",
                                                         br(),br(),
                                                         img(src="map.jpg", width=219,height=160)
                                                         
                                                  )
                                                )
                                         )
                                         
                                       )
                                
                              )
                            ),
                   tabPanel("Estimator",
                            
                            fluidPage(
                              fluidRow(
                                column(4, align="center",
                                       wellPanel(
                                         h3('1. Select properties of your wine:'),
                                         sliderInput('crit1', HTML("Fixed Acidity (tartaric acid) - g/dm<sup>3<sup>"), 8.3, min=4.6, max=15.9, step=0.1),
                                         sliderInput('crit2', HTML("Volatile  Acidity (acetic acid) - g/dm<sup>3</sup>"), 0.55, min=0.15, max=1.55, step=0.05),
                                         sliderInput('crit3', HTML("Citric Acid (freshness & flavor) - g/dm<sup>3</sup>"), 0.30, min=0, max=1, step=0.05),
                                         sliderInput('crit4', 'pH', 3.35, min=2.75, max=4, step=0.05),
                                         sliderInput('crit5', HTML("Sulphates (additive) - g/dm<sup>3</sup>"), 0.65, min=0.35, max=2, step=0.05),
                                         sliderInput('crit6', HTML("Residual Sugar (sweetness) - g/dm<sup>3</sup>"), 2.5, min=1, max=15, step=0.5),
                                         sliderInput('crit7', HTML("Sodium Chloride (saltiness) - g/dm<sup>3</sup>"), 0.1, min=0.01, max=0.6, step=0.01),
                                         sliderInput('crit8', HTML("Free Sulfur Dioxide SO2 (against oxydation & microbs) - mg/dm<sup>3</sup>"), 16, min=1, max=72, step=1),
                                         sliderInput('crit9', HTML("Total Sufur Dioxide SO2 - mg/dm<sup>3</sup>"), 50, min=5, max=290, step=5),
                                         sliderInput('crit10', HTML("Density - g/cm<sup>3</sup>"), 0.9965, min=0.9905, max=1.0040, step=0.0005),
                                         sliderInput('crit11', 'Alcohol - % by volume', 10.5, min=8.5, max=15, step=0.1),
                                         actionButton("estimate","Estimate")
                                         
                                       )
                                ),
                                column(8, align="center",
                                       h2('2. Visualize your selection among other red "Vinho Verde":'),
                                       plotOutput('colLegend', height="100%"),
                                       fluidRow(
                                         column(6, align="center",
                                                plotOutput('plot1')
                                         ),
                                         column(6,align="center",
                                                plotOutput('plot2')
                                         )
                                       ),	
                                       fluidRow(
                                         column(6, align="center",
                                                plotOutput('plot3')
                                         ),
                                         column(6,align="center",
                                                plotOutput('plot4')
                                         )
                                       ),	
                                       fluidRow(
                                         column(6, align="center",
                                                plotOutput('plot5')
                                         ),
                                         column(6,align="center",
                                                plotOutput('plot6')
                                         ),
                                         h2('3. Estimation of the quality of your selection:'),
                                         plotOutput('estquality')
                                         
                                       )
                                )
                              )
                            )),
                            
                            tabPanel("Author & source code",
                                     fluidPage(
                                       fluidRow(
                                         column(width = 3),
                                         column(width=9,
                                                h2("Author and source code"),
                                                p("This tool was realized by ",
                                                  strong(a("JS Gourdet",href="https://www.linkedin.com/in/jsgourdet")),
                                                  " in the frame of the ",
                                                  a("Data Science Specialization",href="https://www.coursera.org/specialization/jhudatascience/1"),
                                                  " by the Johns Hopkins University."
                                                  ),
                                                p("The source code is available on ",
                                                  a("Github",href="https://github.com/geojsg/winequality")
                                                  )
                                                )
                                       )
                                     )
                            )   
                            )
)
