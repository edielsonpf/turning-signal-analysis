mydata <- read.table("energy.csv", header=TRUE, sep=",")
library(plotly)
plot_ly(data = mydata, x = Ry, y = PC1, mode = "markers", color = CS, filename="r-docs/scatter-with-qualitative-colorscale")