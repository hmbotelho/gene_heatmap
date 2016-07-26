library(shiny)

shinyUI(fluidPage(
    titlePanel("Gene Heatmap"),
    sidebarLayout(
        sidebarPanel(
            helpText("Please upload a file from your computer and select plotting options."),
            
            fileInput('file1', 'Choose File',
                      accept=c('text/csv', 
                               'text/comma-separated-values,text/plain', 
                               '.csv')),
            radioButtons('sep', 'Separator',
                         c(Comma=',',
                           Semicolon=';',
                           Tab='\t'),
                         ','),
            tags$hr(),
            
            numericInput("numcolors", "Color gradations", value=2, min=2, max=3, step=1),
            sliderInput("tweak", "Color adjustment (only for 3 gradations)", min=0, max=3, value=1, step=0.1),
            
            h3("Change Color"),
            radioButtons('lowCol', 'Low value',
                         c(Green='green',
                           Blue='blue',
                           Purple='purple',
                           Red='red',
                           Orange='orange',
                           Yellow='yellow'),
                         ','),
            radioButtons('highCol', 'High value',
                         c(Green='green',
                           Blue='blue',
                           Purple='purple',
                           Red='red',
                           Orange='orange',
                           Yellow='yellow'),
                         ','),
            
            tags$hr(),
            sliderInput("marLower", "Margin (down)",  min=0, max=20, value=5, step=0.5),
            sliderInput("marRight", "Margin (right)", min=0, max=20, value=5, step=0.5),
            
            br(),
            tags$hr(),
            p(strong("Author: "), "Hugo Botelho, 2016", a("e-mail" , href= "mailto:hugobotelho@gmail.com"))
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Heatmap",
                    h2("Heatmap with clustering"),
                    plotOutput("heatmapC"),
                    downloadButton('downloadPlot1', 'Download Plot'),
                    tags$hr(),
                    h2("Heatmap without clustering"),
                    plotOutput("heatmap"),
                    downloadButton('downloadPlot2', 'Download Plot')
                ),
                tabPanel("Source Data",
                    dataTableOutput("valuestable")
                )
            ),
            br(),br(),
            p(strong("Reference:"), "Khomtchouk ", tags$i("et al"), "(2014) Source Code Biol Med 9(1):30 [", a("URL", href = "http://www.ncbi.nlm.nih.gov/pubmed/25550709"), "]")
        )
    )
))