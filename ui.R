library(shiny)

shinyUI(fluidPage(
    titlePanel("Gene Heatmap"),
    sidebarLayout(
        sidebarPanel(
            helpText("Please upload a file from your computer and select plotting options."),
            
            fileInput('file1', 'Choose CSV File',
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
            br(),
            tags$hr(),
            p(strong("Author: "), "Hugo Botelho, 2016", a("e-mail" , href= "mailto:hugobotelho@gmail.com"))
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Heatmap",
                    h2("Heatmap with clustering"),
                    plotOutput("heatmapC"),
                    tags$hr(),
                    h2("Heatmap without clustering"),
                    plotOutput("heatmap")
                ),
                tabPanel("Source Data",
                    dataTableOutput("valuestable")
                )
            )
        )
    )
))