# Exemplos de datasets com associação de palavras a sentimentos - pacote 
# 'tidytext'
get_sentiments('bing')
get_sentiments('afinn')
get_sentiments('nrc')

# Forma de análise de sentimentos - inner join
tidy_book <- austen_books() %>% 
  group_by(book) %>% 
  unnest_tokens(word, text)

# Palavras mais comuns relacionadas a 'prazer' para análise de sentimentos
# lexicon 'nrc'
nrc_joy <- get_sentiments('nrc') %>% 
  filter(sentiment == 'joy')

# Realizar inner join com o livro 'Emma' - análise de sentimentos
book <- tidy_book %>%
  filter(book == 'Emma') %>% 
  inner_join(nrc_joy) %>% 
  count(word, sort = TRUE)

# Utilizando o lexicon 'bing' para calcular o sentimento em polaridade
jane_austen_sentiment <- tidy_book %>% inner_join(get_sentiments('bing'))

# Analisando para o livro 'persuasion'
persuasion_sentiment <- jane_austen_sentiment %>% 
  filter(book == 'Persuasion')

persuasion_sentiment <- persuasion_sentiment %>% 
  mutate(net_sentiment = ifelse(sentiment == 'positive', 1, -1))

sum(persuasion_sentiment$net_sentiment)

# Apresentando os resultados em forma de wordcloud
mansfield <- tidy_book %>% 
  filter(book == 'Mansfield Park')

mansfield %>% 
  inner_join(get_sentiments('bing')) %>% 
  count(word, sentiment, sort = TRUE) %>% 
  acast(word ~ sentiment, value.var = 'n', fill = 0) %>% 
  comparison.cloud(colors = c('red', 'green'), 
                   scale = c(1,.5),
                   max.words = 100, match.colors = T, title.size = .8,
                   title.bg.colors = 'black')
