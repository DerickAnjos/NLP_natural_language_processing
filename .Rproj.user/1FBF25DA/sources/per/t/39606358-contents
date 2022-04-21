# Buscando dados na internet - pacote 'rvest' -----------------------------


# Página: https://en.wikipedia.org/wiki/Web_scraping

# Função para ler os dados (html)
wikipedia <- read_html('https://en.wikipedia.org/wiki/Web_scraping')
class(wikipedia)

# Buscado nó 'título', que aparece na aba da página no navegador
wikipedia %>% html_elements('title')

# Para uma mensagem limpa, com apenas texto e sem os elementos html:
wikipedia %>% html_elements('title') %>% html_text()

# Buscando nó de heading
wikipedia %>% html_elements('h1') %>% html_text() 

# Buscando nó de parágrafo
paragrafos <- wikipedia %>% html_elements('p') %>% html_text()

length(paragrafos)
paragrafos[2]


# Buscando dados específicos em uma página web - pacote 'rvest' --------------

# Vamos utilizar a seguinte página: https://en.wikipedia.org/wiki/Web_scraping

library('rvest')

# Lendo os dados
wikipedia <- read_html('https://en.wikipedia.org/wiki/Web_scraping')

# Busca específica
# "Ticketmaster Corp. v. Tickets.com, Inc".

body_text <- wikipedia %>% html_elements('#cite_note-9') %>% html_text()
body_text

# Utilizando a função 'substr' a título de exemplo. Essa função é muito 
# utilizada nesse tipo de projeto
substr(body_text, start = 1, stop = 41)
substr(body_text, start = 42, stop = nchar(body_text))

# Buscar item listado
techniques <- wikipedia %>% html_elements('#Techniques') %>% html_text()
techniques


# Busca dados específicos da web page - pacote 'httr' ---------------------

# Vamos utilizar a página: 
# 'http://www.r-datacollection.com/materials/html/OurFirstHTML.html'
library('httr')

# Usa método GET()
website <- 
  GET('http://www.r-datacollection.com/materials/html/OurFirstHTML.html')
class(website)

content(website, type = 'text')


# Busca dados específico em uma API do IBGE - pacote 'httr' ---------------
library('rvest')
library('httr')
library('jsonlite')

# API por país do IBGE
# https://servicodados.ibge.gov.br/api/docs/paises

# Parâmetros
# country = BR
# '77823' - PIB per capita
# '77819' - Gastos com educação

# 1 - Listagem de indicadores - mostra na página WEB

url <- "https://servicodados.ibge.gov.br/api/v1/paises/indicadores/77823"

page_data <- GET(url)
class(page_data)
http_type(page_data)

result <- fromJSON(rawToChar(page_data$content))
class(result)

View(result)

# 2 - Indicadores 

url2 <- 'https://servicodados.ibge.gov.br/api/v1/paises/BR/indicadores/77819'

page_data2 <- GET(url2)
http_type(page_data2)

result2 <- fromJSON(rawToChar(page_data2$content))
jsonText <- content(page_data2, 'text')
jsonParsed <- content(page_data2, 'parsed') # Parsing é o processo de analisar
# um texo para determinar sua estrutura lógica  
