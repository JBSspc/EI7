# ============================================================================================
# AUTORES: David Omar Beltrán Hernández, Joshelyn Yanori Mendoza Alfaro, Sofía Palacios Cuevas 
# ESTANCIA DE INVESTIGACIÓN VII, PROYECTO FINAL
# FECHA: 03 DIC 2023
# ============================================================================================

# LIBRERÍAS
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(shinyWidgets)
library(bslib)



# BASE DE DATOS
load("newdb.RData")


# Assuming your PNG files are in a folder named 'images'
png_folder_path <- "www/"

# List PNG files in the folder
png_files <- list.files(png_folder_path, pattern = "\\.png$", full.names = FALSE)


# UI
ui <- navbarPage(" LupusLifeSymphony",
                 tabPanel("Calidad de vida",
                          titlePanel(strong("Calidad de vida de un paciente con Lupus")),
                          p(strong("Autores:"),"David Omar Beltrán Hernández, Joshelyn Yanori Mendoza Alfaro, Sofía Palacios Cuevas "),
                          
                 sidebarPanel(
                            selectInput(
                              inputId = "variable", # Pregunta de calidad de vida
                              label = "Aspecto relacionado con la calidad de vida: ",
                              choices = colnames(newdb[,3:28])
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
                 
                 )), # FIN DE sidebarPanel
                 mainPanel(
                           h3(strong("Introducción")),
                           p(style="text-align: justify;","El presente proyecto se enfoca en el diseño e implementación de una aplicación que permite visualizar las variables de tiempo de diagnóstico y calidad de vida para los sujetos con diagnóstico de lupus. "),
                           p(style="text-align: justify;","En esta entrega, se incluyen gráficos estáticos que se  intregarán en un ambiente reactivo, con el fin de que el usuario pueda escoger una variable relacionada con la calidad de vida y pueda visualizar cómo ha sido la calidad de vida de los pacientes con lupus, según el tiempo de diagnóstico que tienen (desde el dianóstico formal hasta el momento en que se registró en la base de datos). Lo anterior, puede ayudarles a conocer algunas características que podrían esperar de la enfermedad en los próximos años."),
                           br(),
                           plotOutput(outputId = "plot")) # FIN DE mainPanel
                 ),# FIN DE TAB Calidad de vida
                          
                 tabPanel("Síntomas",
                          titlePanel(strong("Síntomas experimentados por los pacientes a lo largo del tiempo")),
                          p(strong("Autores:"),"David Omar Beltrán Hernández, Joshelyn Yanori Mendoza Alfaro, Sofía Palacios Cuevas "),
                            sidebarPanel(
                              selectInput("imageSelector", "Seleccione el tiempo de diagnóstico:",
                                          choices = c("0 años" = "www/0.png",
                                                      "medio año" = "www/0.5.png",
                                                      "1 año" = "www/1.png",
                                                      "1 año, 8 meses" = "www/1.67.png",
                                                      "2 años" = "www/2.png",
                                                      "2 años, 2 meses" = "www/2.17.png",
                                                      "2 años, 5 meses" = "www/2.42.png",
                                                      "2 años, 9 meses" = "www/2.75.png",
                                                      "3 años" = "www/3.png",
                                                      "4 años" = "www/4.png",
                                                      "5 años" = "www/7.png",
                                                      "6 años" = "www/6.png",
                                                      "7 años" = "www/7.png",
                                                      "8 años" = "www/8.png",
                                                      "9 años" = "www/9.png",
                                                      "10 años" = "www/10.png",
                                                      "11 años" = "www/11.png",
                                                      "12 años" = "www/12.png",
                                                      "13 años"= "www/13.png",
                                                      "13 años, 5 meses" = "www/13.42.png",
                                                      "14 años" = "www/14.png",
                                                      "15 años" = "www/15.png",
                                                      "16 años" = "www/16.png",
                                                      "17 años" = "www/17.png",
                                                      "19 años" = "www/19.png",
                                                      "20 años" = "www/20.png",
                                                      "22 años" = "www/22.png",
                                                      "23 años" = "www/23.png",
                                                      "24 años" = "www/24.png",
                                                      "25 años" = "www/25.png",
                                                      "32 años" = "www/32.png",
                                                      "34 años"= "www/34.png",
                                                      "40 años" = "www/40.png"
                                                      )
                              ), # FIN DE selectInput
                              p(strong("Descripción de los síntomas:")),
                              p(style="text-align: justify;",strong("convulsion"),"Convulsión reciente (excluir si ha tenido convulsiones asociadas a desordenes metabólicos (como diabetes), por drogas, infecciones y fármacos."),
                              p(style="text-align: justify;",strong("psicosis"),"Perturbación grave de la percepción de la realidad, alucinación, incoherencia, disociación, hipoacusia (sordera parcial), catatonia (anomalidades motoras)."),
                              p(style="text-align: justify;",strong("sindrome_cereb_org"),"Síndrome cerebral orgánico. Alteración en función mental/intelectual. "),
                              p(style="text-align: justify;",strong("conciencia"),"Pérdida de la atención, incoherencia, insomnio, mareos."),
                              p(style="text-align: justify;",strong("alteracion_visual"),"Alteración visual, cambios en retina. Excluir hipertensión arterial. "),
                              p(style="text-align: justify;",strong("alteracion_nervios"),"Alteración de los nervios craneales. Neuropatía motora (daño a nivel nervioso). "),
                              p(style="text-align: justify;",strong("cefalea_lupica"),"Cefalea lúpica (dolor de cabeza), Cefalea intensa, persistente, migraña; no responde al tratamiento. "),
                              p(style="text-align: justify;",strong("accidente_cerebrovasc"),"Accidente cerebral vascular (Excluir hipertensión arterial, trombocitopenia (baja de plaquetas)). "),
                              p(style="text-align: justify;",strong("vasculitis"),"Vasculitis, ulceración, gangrena, nódulos blandos, dedos, infarto periungueal (fenómeno de Reynaud), hemorragias en llamas, biopsia (+). "),
                              p(style="text-align: justify;",strong("artritis"),"Artritis. Más de dos articulaciones dolorosas con inflamación. "),
                              p(style="text-align: justify;",strong("miositis"),"Miositis (inflamación muscular). Mialgia/debilidad proximal, CPK/aldolasa elevada, electromiografía alterada, biopsia (+). "),
                              p(style="text-align: justify;",strong("cilindros_urin"),"Cilindros urinarios. Hemáticos o granulares."),
                              p(style="text-align: justify;",strong("hematuria"),"Hematuria > 5g/c (Presencia de sangre en orina) "),
                              p(style="text-align: justify;",strong("proteinuria"),"Proteinuria > 0.5 mg/24 h o elevada. "),
                              p(style="text-align: justify;",strong("piuria"),"Piuria > 5 gb/c. "),
                              p(style="text-align: justify;",strong("erupcion"),"Erupción. Episodio nuevo o recurrente; erupción inflamatoria. "),
                              p(style="text-align: justify;",strong("alopecia"),"Alopecia (Pérdida de cabello). Nueva o recurrente. "),
                              p(style="text-align: justify;",strong("ulcera_mocosa"),"Úlcera mucosa, Idem, oral/nasal."),
                              p(style="text-align: justify;",strong("pleuresia"),"Pleuresia. Dolor pleurítico + frote, derrame, engrosamiento pleural. "),
                              p(style="text-align: justify;",strong("pericarditis"),"Pericarditis. Dolor pericárdico con al menos uno de los siguientes: roce, derrame, alteración en electrocardiograma o ecocardiograma. "),
                              p(style="text-align: justify;",strong("hipocomplem"),"Hipocomplementemia. Disminución CH50, C3, C4, (proteínas del complemento) por debajo de límite, inferior normal. "),
                              p(style="text-align: justify;",strong("aumento_union"),"Aumento unión ADN > 25% "),
                              p(style="text-align: justify;",strong("Fiebre"),"Fiebre > 38%"),
                              p(style="text-align: justify;",strong("trombocitopen"),"Trombocitopenia < 100,000/mm3 (Plaquetas bajas)"),
                              p(style="text-align: justify;",strong("leucopenia"),"Leucopenia < 3,000/mm3 (Leucocitos bajos). "),
                              p(style="text-align: justify;",strong("ninguno"),"Ninguno")
                            ), # FIN DE sidebarPanel
                            mainPanel(
                              imageOutput("pngImage", width = "100%")
                            )
                          
                 )  # FIN DE TAB Síntomas
                 ) # FIN DE navbarPage

# SERVER
# TAB Calidad de Vida
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
      geom_point(position = "jitter", size=5) +
      xlab("Tiempo de diagnóstico (años)") +
      ylab("Incidencia") +
      ggtitle(paste("Tiempo de diagnóstico y", input$variable)) +
      scale_colour_hue() +
      guides(colour = guide_legend(title = paste("¿Cómo puntuaría su", input$variable, "?"))) +
      theme(text = element_text(size = 15))
  })
  
  # TAB Síntomas
  output$pngImage <- renderImage({
    list(src = input$imageSelector, contentType = "image/png")
  }, deleteFile = FALSE)
  
  
  
}

# SHINY APP
shinyApp(ui=ui, server = server)


