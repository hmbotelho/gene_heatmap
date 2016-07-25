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
        
    
    heatmapC <- reactive(
        generateHeatmap(rawdata, cluster = TRUE,
                        ncolsteps = nc(),
                        colors = c(loC(), hiC()),
                        tweakcolor = tw()
        )
    )
    
    heatmap <- reactive(
        generateHeatmap(rawdata, cluster = FALSE,
                        ncolsteps = nc(),
                        colors = c(loC(), hiC()),
                        tweakcolor = tw()
        )
    )
    
    output$heatmapC <- renderPlot(heatmapC())
    output$heatmap  <- renderPlot(heatmap())
    
    output$downloadPlot1 <- downloadHandler(
        filename = 'heatmap_clustering.png',
        content = function(file) {
            png(file, width=1000, height=1000)
            print(heatmapC())
            dev.off()
        })
    
    output$downloadPlot2 <- downloadHandler(
        filename = 'heatmap.png',
        content = function(file) {
            png(file, width=1000, height=1000)
            print(heatmap())
            dev.off()
        }) 
    
})