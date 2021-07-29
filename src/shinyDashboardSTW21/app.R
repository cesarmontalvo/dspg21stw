library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(rsconnect)


ui <- fluidPage(
  theme ="themes.css",
  
  navbarPage(title = span("Skilled Technical Workforce", style = "color:#232D4B"),
             tabPanel("About",style = "margin:45px",
                      fluidRow(
                        #column(3, tags$img(height = "80%", width = "80%", src = "biilogo.png")),
                        column(6, h1("Skilled Technical Workforce (STW)")),
                        column(3, tags$img(height = "80%", width = "80%", src = "partnerlogos.png", align = "right"))
                      ),
                      
                      h5("SDAD/DSPG"),
                      p("The Social and Decision Analytics Division (SDAD) is one of three research divisions within the Biocomplexity Institute and Initiative at the University of Virginia.
                        SDAD combines expertise in statistics and social and behavioral sciences to develop evidence-based research
                        and quantitative methods to inform policy decision-making and evaluation.
                        The researchers at SDAD span many disciplines including statistics, economics, sociology, psychology,
                        political science, policy, health IT, public health, program evaluation, and data science.
                        The SDAD office is located near our nation's capital in Arlington, VA. You can learn more about us at",
                        tags$a(href="https://biocomplexity.virginia.edu/social-decision-analytics.", "https://biocomplexity.virginia.edu/social-decision-analytics."), style = "color:#232D4B"),
                      p("The Data Science for the Public Good (DSPG) Young Scholars program is a summer immersive program held at SDAD. Entering its seventh year, the program engages students from across the country
                        to work together on projects that address state, federal, and local government challenges around critical social issues relevant in the world today.
                        DSPG young scholars conduct research at the intersection of statistics, computation, and the social sciences to determine how information
                        generated within every community can be leveraged to improve quality of life and inform public policy. ", style = "color:#232D4B"),
                      h5("DSPG21STW Summer Project"),
                      p("Employment in the Skilled Technical Workforce (STW) requires a high level of knowledge in a technical domain and does not require a bachelor’s degree for entry.  These jobs are important because they provide a path to the middle class, and they foster US innovation and shared prosperity through having a workforce with a diverse technical skillset.  By 2022, the US will have 2.4 million unfilled STW jobs.  This summer, our goal was to create a list of nondegree credentials for jobs in the STW."),
                      
                      p("During the 10-week DSPG program, the STW team documented data sources to create a normalized dataset for STW jobs.  We used text matching to compare this data with job ads data and analyzed credential portability through network analysis."),
                      
                      h5("Our Team"),
                      
                      
                      p("SDAD: Vicki Lancaster and Cesar Montalvo"),
                      p("DSPG: Emily Kurtz (Fellow), Haleigh Tomlin (Intern), Madeline Garrett (Intern)"),
                      p("Sponsor: Gigi Jones, National Science Foundation (NSF), National Center for Science and Engineering (NCSES)")
                      
                      
             ),
             
             #ui
             navbarMenu("Profiling",
                        
                        tabPanel("Publishers", style = "margin:20px",
                                 h5("Visuals"),
                                 br(),
                                 br(),
                                 br(),
                                 sidebarLayout(
                                   sidebarPanel(
                                     h4("Top Publishers"),
                                     selectInput("year", "Year", choices = c(2013, 2014,2015,2016,2017,2018))),
                                   mainPanel(
                                     imageOutput("pub"))
                                 )
                                 
                        ),
                        
                        tabPanel("Profiles", style = "margin:60px",
                                 h5("Profiling", align = "center"),
                                 p(style = "margin-top:25px","Profiling is essential for ensuring the contents of datasets align with the projects overall goal and resources. The first goal of the Business Innovation project is to obtain a general understanding of what companies are the ones producing recent innovation. Therefore, we profiled the DNA data to include only unique, complete and valid entries.  We defined a valid entry, as an article that was published after 2010, had more than 100 but less than 10,000 characters and had a company code that was in the company codes dictionary. The year restriction will allow us to only consider recent innovations, the character restriction will allow our computing resources to fully analyze the text and the company code restriction will ensure that we have the full name of the company which will provide better insights on the companies completing innovation. " ),
                                 br(),
                                 p("Originally, the dataset contained 1,942,855 data entries. Given a restriction on memory and running power, we decided to only have unique and complete entries as it diminished the dataset by 96.2% to 73, 688 entries, while still fulfilling our main goal of understanding what companies are producing innovation. The visualization [above/below] demonstrates the total percentage of data entries that passed our validity checks.  About 78.3% of the total unique entries passed the validity check, 100% of the entries were published after 2010, and 91.7% of the entries contained valid company codes.  "),
                                 sidebarLayout(
                                   sidebarPanel(
                                     width = 6,
                                     selectInput("selectTable", "Select", choices = c("Completeness, Uniqueness, Duplicates", "Validity")),
                                     h4("Definitions: ", style = "margin-top:50px"),
                                     helpText("Note: All definitions are provided by Dow Jones Developer Platform"),
                                     tags$ul(
                                       tags$li("an - Accession Number (Unique id)"),
                                       tags$li("art: Caption text and other descriptions of images and illustrations"),
                                       tags$li("action: Action perfomed on a document (ex. add, rep, del)"),
                                       tags$li("body: The content of the article"),
                                       tags$li("byline: The author of an article"),
                                       tags$li("copyright: Copyright text"),
                                       tags$li("credit: Attribution text"),
                                       tags$li("currency_codes: Currencies"),
                                       tags$li("dateline: Place of origin and date"),
                                       tags$li("document_type: Document type (ex. article, multimedia, summary"),
                                       tags$li("ingestion_datetime: Data and time the artile was added to the Dow Jones Developer Platfrom"),
                                       tags$li("language_code: Code for teh published language (ex. en)"),
                                       tags$li("modification_datetime: Data and time that the article was modified"),
                                       tags$li("modification_date: Date in which the article was last modified"),
                                       tags$li("publication_date: Date in which the article was published"),
                                       tags$li("publication_datetime: Date and time in which the article was published"),
                                       tags$li("publisher_name: Publisher name"),
                                       tags$li("region_of_origin: Publisher's region of origin"),
                                       tags$li("snippet: What you see of an article outiside the paywall"),
                                       tags$li("source_code: Publisher code"),
                                       tags$li("source_name: Name of the source"),
                                       tags$li("title: Title text"),
                                       tags$li("word_count: Document word count"),
                                       tags$li("subject_codes: News subjects"),
                                       tags$li("region_codes: Region codes (ex. usa, namz, etc"),
                                       tags$li("industry_codes: Industry codes"),
                                       tags$li("person_codes: Persons"),
                                       tags$li("market_index_codes: Market indices"),
                                       tags$li("company_codes: Factiva IDs for companies and organizations"),
                                       tags$li("company_codes_about: Companies that have high relevance to the document"),
                                       tags$li("company_codes_association: Companies added to the document because of a relationship other than parent/child"),
                                       tags$li("company_codes_lineage: Companies added to the document because of a parent/child relationship to another company"),
                                       tags$li("company_codes_occur: Companies mentioned in the document but that do not necessarily have a high relevance to it"),
                                       tags$li("company_codes_relevance: Companies added to the document because they have a certain degree of relevance to it")
                                       
                                     )
                                     
                                   ),
                                   mainPanel(width = 3, tableOutput("tables"))
                                 ))
             ),
             #end profiling tab------------------------------------------
             
             
             
             
             
             tabPanel("Methods",
                      h3("Methods", align = "center", style = "margin-bottom: 50px"),
                      style = "margin-left: 120px;",
                      style = "margin-top: 30px;",
                      style = "margin-right: 120px;",
                      
                      
                      fluidRow(style = "margin-top:100px",
                               column(3, h4("Web Scraping")),
                               column(6, wellPanel(p(style = "font-size:15px","To collect the credential and SOC data from O*NET, we used R’s rvest web scraping package. We looped through the list of 133 Skilled Technical Workforce SOC codes and found all associated credentials for each. O*NET also reports the certifying organization and the type of credential, so we collected that information as well. In the end, we created a data frame with 1137 rows and 4 columns.  ")))
                      ),
                      hr(),
                      fluidRow(style = "margin-top:100px",
                               column(3, h4("Cleaning")),
                               column(6, wellPanel(p(style = "font-size:15px","To match credentials across the O*NET, BGT, and VA Community Colleges data sources, we had to perform some preliminary data cleaning. We used regular expressions to remove acronyms within parentheses in the BGT dataset and states in the Community Colleges dataset. We also removed stop words and stemmed the words in the datasets, removing common, superfluous suffixes. Once the credentials were cleaned within all three datasets, we were ready to perform our text matching.")))
                      ),
                      hr(),
                      fluidRow(style = "margin-top:100px",
                               column(3, h4("Text Matching")),
                               column(6, wellPanel(p(style = "font-size:15px","Filling crucial jobs in the Skilled Technical Workforce requires coordination between governments, industries, and educational institutions. Unfortunately, there are inconsistencies in the language these three bodies use to describe the credentials required for these jobs. We used text matching methods to address some of these inconsistencies. To do this, we used the stringdist and lingmatch R packages. Specifically, we used the stringdist function within the stringdist package to calculate the Damerau-Levenshtein distance between each pair of credentials across our three datasets. The lingmatch package allowed us to easily create matrices where words were represented by columns and credentials were represented by rows. This aided the distance calculations across each pair of data sources.  ")))
                      ),
                      hr(),
                      fluidRow(style = "margin-top:100px",
                               column(3, h4("Network Analysis")),
                               column(6, wellPanel(p(style = "font-size:15px","We used the R package igraph in order to visualize the links between occupations and credentials within the Skilled Technical Workforce. By visualizing these links and combining supplemental information, such as the projected growth of specific occupations in the STW, we are able to analyze the paths workers can take in the STW.  ")))
                      )
                      
                      
                      
                      
             ),#),#end navbar
             
             #end Data Sources and Methods tabs-----------------
             
             
             navbarMenu("Results",
                        tabPanel("Across Data Matching",
                                 selectInput("across", "Select", choices = c("ONETxBGT", "ONETxVA", "VAxBGT")),
                                 dataTableOutput("AcrossData")
                                 
                                 
                                 
                        ),
                        
                        tabPanel("Networks", style = "margin:20px",
                                 h5("Network Visualizations"),
                                 br(),
                                 br(),
                                 br(),
                                 sidebarLayout(
                                   sidebarPanel(
                                     h4("Occupation"),
                                     selectInput("network", "Occupation", choices = c("Nursing", "Cybersecurity", "Manufacturing")),
                                     selectInput("increasing", "Projected % Chance in Occupation", choices = c("Don't Show", "Show"))),
                                   mainPanel(
                                     imageOutput("netgraph")))),
                        
                        tabPanel("Boxplots",style="margin:20px",
                                 h5("Boxplots", align = "center"),
                                 p(style = "margin-top:25px","To visualize the relationships between the named credentials within the three main datasets, we created boxplots. One natural question to ask is whether there are more precise matches in how credentials are referenced within certain types of jobs. Within the Skilled Technical Workforce, there are 14 occupational groups. These are: 1) 11. Agriculture, Forestry, Fishing, and Hunting, 2) 13. 3) 17. 4) 19. 5) 27. 6) 29. 7) 33. 8) 35. 9) 43. 10) 45. 11) 47. 12) 49. 13) 51. Information, and 14) 53. Real Estate and Rental and Leasing. The boxplot below shows the confidences for our text matching algorithm between Burning Glass credentials and O*NET credentials for each of these occupational groups. While some groups' confidences are somewhat higher than others, all results are somewhat low. This highlights the gaps between industries, governments, and educational institutions, and shows these gaps manifest even in the language used to discuss occupations and credentials. " ),
                                 #br(),
                                 #p("Originally, the dataset contained 1,942,855 data entries. Given a restriction on memory and running power, we decided to only have unique and complete entries as it diminished the dataset by 96.2% to 73, 688 entries, while still fulfilling our main goal of understanding what companies are producing innovation. The visualization [above/below] demonstrates the total percentage of data entries that passed our validity checks.  About 78.3% of the total unique entries passed the validity check, 100% of the entries were published after 2010, and 91.7% of the entries contained valid company codes.  "),
                                 imageOutput("bgtonetbox")
                                 
                                 
                                 )#end results tab 
             ), #end navbarPage
             #navbarMenu("Data Sources",
             tabPanel("Data Sources",
                      h3("Data Sources", align = "center", style = "margin-bottom: 50px"),
                      style = "margin-left: 120px;",
                      style = "margin-top: 30px;",
                      style = "margin-right: 120px;",
                      fluidRow(
                        column(3, tags$img(height = "100%", width = "100%",src = "dnalogo.png")),
                        column(6, wellPanel(p(style = "font-size:15px","The Dow Jones DNA platform collects information from Dow Jones publication with premium and licensed third party sources. This proprietary data platform contains 1.3bn articles each labeled with unique DNA taxonomies tags including word count, source name, and company code. More information on all the included data tags can be found on the DNA website. This dataset served as the primary resource for alternative text sources and will inspire the machine learning algorithms that will predict innovation. "))),
                      ),
                      hr(),
                      fluidRow(style = "margin-top:100px",
                               column(3, tags$img(height = "100%", width = "100%", src = "fdalogo.png")),
                               column(7, wellPanel(
                                 tags$b("Approvals"),
                                 p(style = "font-size:15px", "FDA drug approvals dataset generated and reviewed by FDA and includes information regarding. ",
                                   br(),
                                   br(),
                                   tags$b("National Drug Code"),
                                   p(style = "font-size:15px", "The National Drug Code (NDC) Directory is a publicly available source provided by the FDA that contains a list of all current drugs manufactured, prepared, propagated, compounded, or processed for commercial distribution. The data content is manually inputted by the companies producing the drugs as required per the Drug Listing Act of 1972. The FDA assigns the NDC – a unique three-digit number, to the drug products. The administration then updates the NDC directory daily with the NDC along with the rest of the information provided. We gathered content from this dataset on [enter date here]. This data was used to cross-validate the companies that we had previously identified as producing an innovation. ")
                                 )))
                      )
                      
             )
  )) #end fluid page





server <- function(input, output) {
  
  output$pub <- renderImage({
    
    # When input$n is 3, filename is ./images/image3.jpeg
    filename <- normalizePath(file.path('www',
                                        paste(input$year, 'Publisherplot.png', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste("Image number", input$year))
    
    
    
  }, deleteFile = FALSE)
  
  
  
  
  
  
  output$tables <- renderTable({
    if(input$selectTable == "Validity"){
      
      
      valid <- read.csv("validitytable.csv")
      names(valid)[names(valid) == "X"] <- "Column Name"
      
      valid
    }else{
      profTable <- read.csv("profilingTable.csv")
      
      names(profTable)[names(profTable) == "X"] <- "Column Name"
      
      profTable
    }
    
  })

  
  output$withinData <- renderDataTable({
    if(input$within == "FDAxFDA"){
      withinTable <- read.csv("fdaxfda.csv")
      
      withinTable$X <- NULL
      withinTable$fuzz.ratio <- NULL
      withinTable$original.row.number <- NULL
      
      names(withinTable)[names(withinTable) == "clean.company.name"] <- "Corporate Family"
      names(withinTable)[names(withinTable) == "company.matches"] <- "Matches"
      names(withinTable)[names(withinTable) == "original.company.names"] <- "Original Company Name"
      
      
      
      
      withinTable
      
    }else if(input$within == "NDCxNDC"){
      withinTable <- read.csv("ndcxndc.csv")
      
      withinTable$X <- NULL
      withinTable$fuzz.ratio <- NULL
      withinTable$original.row.number <- NULL
      
      names(withinTable)[names(withinTable) == "clean.company.name"] <- "Corporate Family"
      names(withinTable)[names(withinTable) == "company.matches"] <- "Matches"
      names(withinTable)[names(withinTable) == "original.company.names"] <- "Original Company Name"
      
      withinTable
    }
  })
  
  output$AcrossData <- renderDataTable({
    if(input$across == "ONETxBGT"){
      acrossTable <- read.csv("onetxbg.csv")
      
      acrossTable$X <- NULL
      acrossTable$fda.row <- NULL
      acrossTable$clean.fda.company.name <- NULL
      acrossTable$clean.ndc.row <- NULL
      acrossTable$fuzz.ratio <- NULL
      acrossTable$clean.ndc.company <- NULL
      
      names(acrossTable)[names(acrossTable) == "original.fda.company"] <- "Original FDA Company"
      names(acrossTable)[names(acrossTable) == "corporate.family"] <- "Corporate Family"
      names(acrossTable)[names(acrossTable) == "original.ndc.company"] <- "Original NDC Company"
      
      acrossTable
    }else if(input$across == "FDAxDNA"){
      acrossTable <- read.csv("fda_dna_matching.csv")
      
      acrossTable$fda.row <- NULL
      acrossTable$clean.fda.company.name <- NULL
      acrossTable$clean.dna.row <- NULL
      acrossTable$fuzz.ratio <- NULL
      acrossTable$clean.dna.company <- NULL
      
      acrossTable$X <- NULL
      
      names(acrossTable)[names(acrossTable) == "original.fda.company"] <- "Original FDA Company"
      names(acrossTable)[names(acrossTable) == "corporate.family"] <- "Corporate Family"
      names(acrossTable)[names(acrossTable) == "original.dna.company"] <- "Original DNA Company"
      acrossTable
    }else{
      acrossTable <- read.csv("ndc_dna_matching.csv")
      
      acrossTable$X <- NULL
      acrossTable$NDC.row <- NULL
      acrossTable$clean.NDC.company <- NULL
      acrossTable$clean.DNA.row <- NULL
      acrossTable$fuzz.ratio <- NULL
      acrossTable$clean.DNA.company <- NULL
      
      names(acrossTable)[names(acrossTable) == "original.NDC.company"] <- "Original NDC Company"
      names(acrossTable)[names(acrossTable) == "corporate.family"] <- "Corporate Family"
      names(acrossTable)[names(acrossTable) == "original.DNA.company"] <- "Original DNA Company"
      
      acrossTable
    }
  })
  
  output$netgraph <- renderImage({
    
    # When input$network is nursing, filename is ./www/nursing.png
    filename <- normalizePath(file.path('www',
                                        paste(input$network, '.png', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste(input$network, "Network"),
         width = 900,
         height = 900)
    
    
    
  }, deleteFile = FALSE)
  
  
  output$bgtonetbox <- renderImage({
    
    # When input$network is nursing, filename is ./www/nursing.png
    filename <- normalizePath(file.path('www',
                                        'BGT_ONET_Box.png', sep=''))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste(input$bgtonetbox, "Boxplots"),
         width = 900,
         height = 600)
    
    
    
  }, deleteFile = FALSE)
  
  
}

# Run the application
shinyApp(ui = ui, server = server)




