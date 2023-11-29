# ============================================================================================
# AUTORES: David Omar Beltrán Hernández, Joshelyn Yanori Mendoza Alfaro, Sofía Palacios Cuevas 
# ESTANCIA DE INVESTIGACIÓN VII, PROYECTO FINAL
# FECHA: 03 DIC 2023
# ============================================================================================

# LIBRERÍAS
library(shiny)
library(ggplot2)
library(dplyr)
library(shinyWidgets)
library(bslib)


# BASE DE DATOS
load("newdb.RData")


# UI
ui <- navbarPage(" LupusLifeSymphony",
                 tabPanel("Calidad de vida",
                          titlePanel(strong("Calidad de vida de un paciente con Lupus")),
                          p(strong("Autores:"),"David Omar Beltrán Hernández, Joshelyn Yanori Mendoza Alfaro, Sofía Palacios Cuevas ")),
                          
                 sidebarPanel(
                            selectInput(
                              inputId = "variable", # Pregunta de calidad de vida
                              label = "Aspecto relacionado con la calidad de vida: ",
                              choices = colnames(newdb[,3:28])
                            )),
                 mainPanel(
                           h3(strong("Introducción")),
                           p(style="text-align: justify;","El presente proyecto se enfoca en el diseño e implementación de una aplicación que permite visualizar las variables de tiempo de diagnóstico y calidad de vida para los sujetos con diagnóstico de lupus. "),
                           p(style="text-align: justify;","En esta entrega, se incluyen gráficos estáticos que se  intregarán en un ambiente reactivo, con el fin de que el usuario pueda escoger una variable relacionada con la calidad de vida y pueda visualizar cómo ha sido la calidad de vida de los pacientes con lupus, según el tiempo de diagnóstico que tienen (desde el dianóstico formal hasta el momento en que se registró en la base de datos). Lo anterior, puede ayudarles a conocer algunas características que podrían esperar de la enfermedad en los próximos años."),
                           plotOutput(outputId = "plot")),
                          
                 tabPanel("Síntomas"))

# SERVER
server <-  server <- function(input, output) {
  reactive_data <- reactive({
    newdb %>%
      count(dx_time, .data[[input$variable]], wt = NULL)
  })
  
  des <- reactive({
    data[, input$varaibleGraf, drop = FALSE]
  })
  
  output$plot <- renderPlot({
    data <- reactive_data()
    data$calidad_vida <- as.factor(data[[input$variable]])
    
    ggplot(data, aes(dx_time, n, colour = calidad_vida)) +
      geom_point(position = "jitter") +
      xlab("Tiempo de diagnóstico (años)") +
      ylab("Incidencia") +
      ggtitle(paste("Tiempo de diagnóstico y", input$variable)) +
      scale_colour_hue() +
      guides(colour = guide_legend(title = paste("¿Cómo puntuaría su", input$variable, "?"))) +
      theme(text = element_text(size = 15))
  })
  
  
  
}

# SHINY APP
shinyApp(ui=ui, server = server)
