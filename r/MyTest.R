mydata <- read.table("energy.csv", header=TRUE, sep=",")

library(plotly)
plotly:::verify("username")
plotly:::verify("api_key")

Sys.setenv("plotly_username"="edielsonpf")
Sys.setenv("plotly_api_key"="cz2ngn3ygz")

plot_ly(data = mydata, x = PC1, y = PC2, mode = "markers", color = Ry, filename="r-docs/scatter-with-qualitative-colorscale")