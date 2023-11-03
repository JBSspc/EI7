# Cargamos los paquetes ------------------------------
library(shiny)
library(ggplot2)
library(dplyr)

# Cargamos los datos ---------------------------------
load("db_lupus_cv.RData")

# Definir la UI --------------------------------------
ui <- fluidPage(
  titlePanel("Calidad de vida de un paciente con Lupus"),
  
  sidebarLayout(
    # Entradas
    sidebarPanel(
      selectInput(
        inputId = "variable", # Pregunta de calidad de vida
        label = "Aspecto relacionado con la calidad de vida: ",
        choices = colnames(rdata[,43:68])
      ),
    ),
    # Salidas
    mainPanel(
    plotOutput(outputId = "plot")
    )
  )
)

# Definir el servidor ------------------------------
server <-function(input, output, session){
  reactive_data <- reactive({
    rdata %>%
      count(dx_time, .data[[input$variable]], wt = NULL)
  })
  
  output$plot <- renderPlot({
    data <- reactive_data()
    data$data[[input$variable]]<-as.factor(data[[input$variable]]) # Aquí está el progblema
    ggplot(data, aes(dx_time, n, colour = data[[input$variable]]) +
       geom_point(position = "jitter") +
       xlab("Tiempo de diagnóstico (años)") +
       ylab("Incidencia") +
       ggtitle("Tiempo de diagnóstico por " + input$variable) +
       #scale_colour_hue(labels = c("Masculino", "Femenino", "Otro")) +
       guides(colour = guide_legend(title = input$variable)) +
       theme_bw())
  })
}

# Crear un objeto de Shiny app --------------------
shinyApp(ui=ui, server = server)
