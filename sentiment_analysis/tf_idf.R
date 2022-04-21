# Vamos aplicar o método tf-idf (term-frequency / inverse document frequency)
# com dois contos do pacote 'gutenberg' - Othello e Contos do Norte

textos <- gutenberg_metadata
livros <- gutenberg_download(c(28526,28691))

book_words <- livros %>%
  unnest_tokens(word, text) %>% 
  count(gutenberg_id, word, sort = TRUE)

# Lei de ZIPF: afirma que a frequencia de uma palavra é inversamente 
# proporcional a sua posição na lista global de palavras depois de classificadas
# por sua frequencia de forma descendente

# Aplicando tf-idf
books_tf_idf <- book_words %>% bind_tf_idf(term = word, document = gutenberg_id,
                                           n = n)

# Analisando os livros separadamente
othello_tf_idf <- books_tf_idf %>% filter(gutenberg_id == 28526)
contor_tf_idf <- books_tf_idf %>% filter(gutenberg_id == 28691)

# Apresentando o resultado de forma gráfica
books_graph <- books_tf_idf %>% 
  group_by(gutenberg_id) %>% 
  slice_max(order_by = tf_idf, n = 15) %>%
  ungroup() %>% 
  mutate(word = reorder(word, tf_idf))

books_graph %>% 
  ggplot(aes(tf_idf, word, fill = gutenberg_id)) +
  geom_col(show.legend = F) +
  labs(x = 'tf-idf', y = 'words')+
  facet_wrap(~gutenberg_id, ncol = 2, scales = 'free')
