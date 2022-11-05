
# Fungsi dashboardPage() diperuntuhkan untuk membuat ketiga bagian pada Shiny
dashboardPage(skin = "blue",
              
              # Fungsi dashboardHeader() adalah bagian untuk membuat header
              
              
              
              dashboardHeader(title = span(tagList(icon("viruses"), "Covid19 Analysis"))),
              # dashboardHeader(title = tags$img(src = "covid-logo.png", height = '60', width ='60', "Covid")),
              
              # Fungsi dashboardSidebar() adalah bagian untuk membuat sidebar
              dashboardSidebar(
                
                #sidebarMenu adalah fungsi untuk membuat bagian menu disamping
                sidebarMenu(
                  
                  #menutItem adalah fungsi untuk membuat kolom tab menu dibagian menu samping
                  menuItem(
                    text = "Home", # text adalah parameter untuk memberikan Nama menu
                    tabName = "menu_1", # tabName adalah parameter memberikan identifikasi yang mewakliki bagian menu tersebut
                    icon = icon("house")), # icon adalah parameter untuk memberikan lambang pada menu tersebut
                  
                  menuItem(text = "Filter Data",
                           tabName = "menu_2",
                           icon = icon("filter")),
                  
                  menuItem(text = "Data",
                           tabName = "menu_3",
                           icon = icon("table"))
                )
              ),
              
              # Fungsi dashboardBody() adalah bagian untuk membuat isi body
              dashboardBody(
                
                # Fungsi tabItems() adalah fungsi untuk mengumupulkan semua isi dari body pada setiap menu
                tabItems(
                  # --------- HALAMAN PERTAMA: MENU 1
                  tabItem(
                    tabName = "menu_1", # tabeName adalah parameter untuk memberi tahu bagian Menu mana yang ingin kita isi atau masukan data
                    
                    # fluiRow() adalah sebuah fungsi untuk membuat layout dengan orientasi baris
                    fluidRow(
                      
                      # infoBox() adalah sebuah fungsi untuk membuat box yang berisikan informasi
                      infoBox(title = "TOTAL BENUA", 
                              value = length(unique(covids_clean$benua)), # Untuk mengeluarkan value tertentu
                              icon = icon("globe"), 
                              color = "red",
                              width = 6),
                      
                      infoBox(title = "TOTAL NEGARA", 
                              value =length(unique(covids_clean$negara)), 
                              icon = icon("flag"), 
                              color = "black",
                              width = 6)
                    ),
                    
                    # --------- BAR PLOT 1
                    fluidRow(
                      
                      # box() adalah fungsi yang digunakan untuk membuat sebuah box yang dapat menambung sebuah plot
                      box(width = 6, # mengatur ukuran dari box
                          title = "Kasus Positif Covid19 Berdasarkan Benua",
                          
                          # plotlyOutput() adalah fungsi untuk menampilkan plot yang sudah dibuat dibagian server
                          plotlyOutput(outputId = "plot_1")
                      ),
                      box(width = 6, # mengatur ukuran dari box
                          title = "Kasus Kematian Covid19 Berdasarkan Benua",
                          
                          # plotlyOutput() adalah fungsi untuk menampilkan plot yang sudah dibuat dibagian server
                          plotlyOutput(outputId = "plot_11")
                      )
                    )
                  ),
                  
                  # --------- HALAMAN KEDUA: COUNTRY
                  tabItem(
                    tabName = "menu_2",
                    
                    # --------- INPUT
                    fluidRow(
                      box(
                        width = 12,
                        
                        # selecInput() adalah fungsi untuk memilih salah satu category youtube
                        selectInput(inputId = "input_benua", # input Id adalah Id atau dari fungsi selectInput
                                    label = "Pilih Benua", # label adalah parameter untuk memberikan nama dari selectInput
                                    choices = unique(covids_clean$benua)) # choices adalah parameter untuk memberikan pilihan category apa saja yang bisa dipilih
                      )
                    ),
                    
                    # --------- PLOT
                    fluidRow(
                      
                      # Plot 2 (kiri)
                      box(
                        plotlyOutput(outputId = "plot_2")
                      ),
                      
                      # Plot 3 (kanan)
                      box(
                        plotlyOutput(outputId = "plot_3")
                      )
                    )
                  ),
                  
                  # --------- HALAMAN KETIGA: DATA
                  tabItem(
                    tabName = "menu_3",
                    
                    # dataTableOutput() adalah fungsi untuk menampilkan dataframe yang sudah kita persiapkan di server
                    DT::dataTableOutput(outputId = "table")
                  )
                  
                )
                
              )
)