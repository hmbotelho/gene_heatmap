#x <- "c:/users/hugo/Desktop/teste.csv"

readFile <- function(path, header=TRUE, sep=",", stringsAsFactors = FALSE){

    if (is.null(path)) {return(NULL)}
    
    rawdata <- read.table(file = path, header = header, sep = sep)
    row.names(rawdata) <- rawdata[,1]
    as.matrix(rawdata[,2:ncol(rawdata)])
}


col2Hue <- function(colorname){
    db <- data.frame(hue   = c(120,     240,    277,      0,     39,       60),
                     color = c("green", "blue", "purple", "red", "orange", "yellow"),
                     stringsAsFactors = FALSE)
    as.numeric(db[db$color == colorname, "hue"])
    
}


generateHeatmap <- function(matrix, cluster=TRUE, ncolsteps = 2, colors = c("red", "green"), tweakcolor = 1){
#par(mar = c(5, 4, 4, 2) + 0.1)
    
    if(is.na(colors[1])) {colors[1] <- "red"}
    if(is.na(colors[2])) {colors[2] <- "green"}
    
    if(ncolsteps == 2){
        LUT <- colorRampPalette(colors)(255)
    } else if (ncolsteps == 3){
        LUT <- diverge_hcl(255, h = c(col2Hue(colors[1]), col2Hue(colors[2])), c = 200, l = c(50*tweakcolor, 50*tweakcolor))
    }
    
    
    if(cluster){
        # Generate heatmap with clustering
        heatmap.2(rawdata, col = LUT, breaks = length(LUT)+1, 
                  keysize = 1.3,
                  key.title = "",
                  key.xlab = "")
        
    } else{
        # Generate heatmap WITHOUT clustering
        heatmap.2(rawdata, col = LUT,
                  breaks = length(LUT)+1,
                  Rowv = FALSE, 
                  Colv = FALSE,
                  dendrogram = "none",
                  trace = "none",
                  density.info = "none",
                  key.title = "",
                  key.xlab = "",
                  keysize = 1.3)
    }
}