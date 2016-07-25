library(shiny)
source("functions.r")
source("dependencies.r")

shinyServer(function(input, output) {
    
    rawdata <- reactive(readFile(input$file1$datapath, sep=input$sep))
    nc <- reactive(as.numeric(input$numcolors))
    loC <- reactive(as.character(input$lowCol))
    hiC <- reactive(as.character(input$highCol))
    tw <- reactive(as.numeric(input$tweak))

    output$valuestable <- renderDataTable({temp <- as.data.frame(rawdata())
                                           temp <- cbind(row.names(temp), temp)
                                           names(temp) <- c("target", colnames(rawdata()))
                                           temp
    })
        
    
    output$heatmapC <- renderPlot(generateHeatmap(rawdata, cluster = TRUE,
                                                 ncolsteps = nc(),
                                                 colors = c(loC(), hiC()),
                                                 tweakcolor = tw()
                                                 ))
    
    output$heatmap <- renderPlot(generateHeatmap(rawdata, cluster = FALSE,
                                                  ncolsteps = nc(),
                                                  colors = c(loC(), hiC()),
                                                  tweakcolor = tw()
                                                  ))
    
})