# Cargamos los paquetes ------------------------------
library(shiny)
library(ggplot2)
library(dplyr)

# Cargamos los datos ---------------------------------
load("db_lupus2.RData")

# Definir la UI --------------------------------------
ui <- fluidPage(
  titlePanel("Calidad de vida de un paciente con Lupus"),
  p(strong("Autores:"),"David Omar Beltrán Hernández, Joshelyn Yanori Mendoza Alfaro, Sofía Palacios Cuevas "),
  
  
  sidebarLayout(
    # Entradas
    sidebarPanel(
      selectInput(
        inputId = "variable", # Pregunta de calidad de vida
        label = "Aspecto relacionado con la calidad de vida: ",
        choices = colnames(db_lupus2[,2:27])
      ),
      p(strong("Descripción de la gráfica")),
      tabsetPanel(type="tab",
                  tabPanel("Calidad de vida",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de los pacientes respecto a su calidad de vida, según el tiempo de diagnóstico.")),
                  tabPanel("Salud",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de los pacientes respecto a su salud, según el tiempo de diagnóstico.")),
                  tabPanel("Impedimento por dolor",
                           p(style="text-align: justify;","Esta gráfica indica la incidencia del nivel de impedimento que el dolor causa en los pacientes, con determinado tiempo de diagnóstico,  para realizar sus actividades diarias.")),
                  tabPanel("Cantidad de medicamento",
                           p(style="text-align: justify;","Esta gráfica indica cuánto medicamento debe utilizar un paciente para realizar sus actividades diarias, según el tiempo de diagnóstico.")),
                  tabPanel("Disfruta la vida",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de los pacientes respecto a su vida, según el tiempo de diagnóstico.")),
                  tabPanel("Vida sin sentido",
                           p(style="text-align: justify;","Esta gráfica indica hasta qué punto los pacientes sienten que su vida tiene sentido, según el tiempo de diagnóstico.")),
                  tabPanel("Concentración",
                           p(style="text-align: justify;","Esta gráfica indica a qué nivel se pueden concentrar los pacientes, según el tiempo de diagnóstico.")),
                  tabPanel("Seguridad",
                           p(style="text-align: justify;","Esta gráfica indica qué tan seguros se sienten los pacientes en su día a día, según el tiempo de diagnóstico.")),
                  tabPanel("Ambiente físico saludable",
                           p(style="text-align: justify;","Esta gráfica indica cuántos pacientes consideran que tienen un ambiente físico nada, poco, normal, muy o extremadamente saludable a su alrededor.")),
                  tabPanel("Capacidad para desplazarse",
                           p(style="text-align: justify;","Esta gráfica indica cuántos pacientes se consideran nada, poco, normal, muy o extremadamente capaces de desplazarse, según el tiempo de diagnóstico.")),
                  tabPanel("Energía suficiente",
                           p(style="text-align: justify;","Esta gráfica indica cuántos pacientes consideran que tienen nada, poco, moderado, suficiente o total energía para su vida diaria, según el tiempo de diagnóstico.")),
                  tabPanel("Aceptar apariencia",
                           p(style="text-align: justify;","Esta gráfica indica cuántos pacientes se consideran nada, poco, moderado, suficiente o totalmente capaces de aceptar su apariencia física, según el tiempo de diagnóstico.")),
                  tabPanel("Dinero suficiente",
                           p(style="text-align: justify;","Esta gráfica indica cuántos pacientes tienen nada, poco, moderado, suficiente o total solvencia económica para cubrir sus necesidades, según el tiempo de diagnóstico.")),
                  tabPanel("Información disponible",
                           p(style="text-align: justify;","Esta gráfica indica el grado de información disponible necesaria en la vida diaria del sujeto, relacionada con el tiempo de diagnóstico.")),
                  tabPanel("Oportunidad de ocio",
                           p(style="text-align: justify;","Esta gráfica indica el grado de oportunidad que tiene una persona para poder realizar actividades de ocio, relacionado con el tiempo de diagnóstico.")),
                  tabPanel("Sueño",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de una persona con lupus con respecto a su sueño, mismo que se responde tomando en cuenta la calidad, horas de sueño, entre otros factores, relacionado con el tiempo de diagnóstico.")),
                  tabPanel("Actividades diarias",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de una persona con su habilidad para realizar sus actividades de la vida diaria, relacionado con el tiempo de diagnóstico.")),
                  tabPanel("Capacidad de trabajar",
                           p(style="text-align: justify;","Esta gráfica indica el grado de satisfacción de la persona, relacionado a su capacidad de trabajo, relacionado con el tiempo de diagnóstico.")),
                  tabPanel("Sí mismo",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de auto satisfacción del individuo, relacionado con el tiempo de diagnóstico.")),
                  tabPanel("Relaciones personales",
                           p(style="text-align: justify;","Esta gráfica indica qué tan satisfecha está la persona con las relaciones personales que ha formado, relacionada con el tiempo de diagnóstico.")),
                  tabPanel("Vida sexual",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de las personas con su vida sexual, dependiendo del tiempo de diagnóstico.")),
                  tabPanel("Apoyo de amigos",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de las personas con el apoyo que han recibido de sus amigos, dependiendo del tiempo de diagnóstico.")),
                  tabPanel("Condiciones de vivienda",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de las personas con sus condiciones de vivienda, dependiendo del tiempo de diagnóstico del padecimiento.")),
                  tabPanel("Acceso a servicios sanitarios",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de las personas con el acceso a servicios sanitarios, dependiendo del tiempo de diagnóstico.")),
                  tabPanel("Transporte",
                           p(style="text-align: justify;","Esta gráfica indica el nivel de satisfacción de las personas con sus medios de transporte, dependiendo del tiempo de diagnóstico.")),
                  tabPanel("Frecuencia de sentimientos negativos",
                           p(style="text-align: justify;","Esta gráfica indica la frecuencia de presentar sentimientos negativos (tristeza, desesperanza, ansiedad, depresión), dependiendo del tiempo de diagnóstico."))
      ),
    
    ),
    
    # Salidas
    mainPanel(
    h3(strong("Introducción")),
    p(style="text-align: justify;","El presente proyecto se enfoca en el diseño e implementación de una aplicación que permite visualizar las variables de tiempo de diagnóstico y calidad de vida para los sujetos con diagnóstico de lupus. "),
    p(style="text-align: justify;","En esta entrega, se incluyen gráficos estáticos que se  intregarán en un ambiente reactivo, con el fin de que el usuario pueda escoger una variable relacionada con la calidad de vida y pueda visualizar cómo ha sido la calidad de vida de los pacientes con lupus, según el tiempo de diagnóstico que tienen (desde el dianóstico formal hasta el momento en que se registró en la base de datos). Lo anterior, puede ayudarles a conocer algunas características que podrían esperar de la enfermedad en los próximos años."),
      
    plotOutput(outputId = "plot"),
    
    )
  )
)

# Definir el servidor -----------------------------------
server <- function(input, output) {
  reactive_data <- reactive({
    db_lupus2 %>%
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

# Crear un objeto de Shiny app --------------------
shinyApp(ui=ui, server = server)
