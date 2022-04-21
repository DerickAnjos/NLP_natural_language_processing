textos <- gutenberg_metadata

# Vamos usar primeiramente 2 exemplos de livros: Moby Dick e Peter Pan
livros <- gutenberg_download(c(15, 16))

# Retirando os números, que vamos considerar que não nos interessa para a 
# análise (apenas como exemplo de técnica)
nums <- livros %>% filter(str_detect(text, '^[0-9]')) %>% select(text)

livros <- livros %>% anti_join(nums, by = 'text')

# Vamos agora retirar as 'stop-words' e obter os tokens
livros <- livros %>% unnest_tokens(word, text) %>% anti_join(stop_words)

# Contando as palavras mais comuns (frequencia) - bag of words (simplificado)
moby <- livros %>% filter(gutenberg_id == 15) %>% count(word, sort = TRUE)

# Definindo a paleta de cores do WordCloud
pal <- brewer.pal(8, 'Dark2')

# Fazendo a WordCloud
moby %>% with(wordcloud(word, freq = n, colors = pal, random.order = FALSE,
                        max.words = 50))

# Peter Pan

# Contando as palavras mais comuns (frequencia) - bag of words (simplificado)
peter <- livros %>% filter(gutenberg_id == 16) %>% count(word, sort = TRUE)

# Definindo a paleta de cores do WordCloud
pal <- brewer.pal(8, 'Dark2')

# Fazendo a WordCloud
peter %>% with(wordcloud(word, freq = n, colors = pal, random.order = FALSE,
                        max.words = 50))


# Exemplo - Biblia Sagrada ----------------------------------------------------

biblia <- read.csv('t_asv.csv')
stop <- read.csv('stop_words.csv')

# Vamos agora retirar as 'stop-words' e obter os tokens.
# Para filtrar um dos livros - 'filter(b == 1)'
biblia <- biblia %>% unnest_tokens(word, t) %>% anti_join(stop)

# Contando as palavras mais comuns (frequencia) - bag of words (simplificado)
biblia_sagrada <- biblia %>% count(word, sort = TRUE)

# Definindo a paleta de cores do WordCloud
pal <- brewer.pal(8, 'Dark2')

# Fazendo a WordCloud
biblia_sagrada %>% with(wordcloud(word, freq = n, colors = pal, random.order = FALSE,
                        max.words = 50))



read_txt




for (i in 1:nrow(indieli_conversa))
{
  indieli_conversa$word[i] <- iconv(indieli_conversa$word[i], 
                                    to = "UTF-8//TRANSLIT")
}
