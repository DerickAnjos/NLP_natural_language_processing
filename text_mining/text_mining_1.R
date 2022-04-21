# Iremos utilizaro dataset 'starwars' para relembrar alguns conceitos do 
# pacote 'dplyr' e do trabalho com bases no formato 'tidy'
st <- starwars

filtro <- st %>% filter(species == 'Droid')
seleciona <- st %>% select(name, ends_with('color'))
imc <- st %>% mutate(imc = mass / ((height/100)^2))

# Utilizado o texto de Edgar Allan Poe - The Black Cat
text <- c("From my infancy I was noted for the docility and humanity of my disposition.",
          "My tenderness of heart was even so conspicuous as to make me the jest of my companions.",
          "There is something in the unselfish and self-sacrificing love of a brute, which goes directly to the heart of him who has had frequent occasion to test the paltry friendship and gossamer fidelity of mere Man.")

text

# Passando para o formato tibble - formato mais adequado para se utilizar o 
# pacote 'tidytext'
text_df <- tibble(line = 1:3, text = text)

# Aplicando o processo de tokenização. Essa função já transforma todas as letras
# em minúsculas e retira as pontuações
df_token <- text_df %>% unnest_tokens(word, text)

# Retirando as 'stop-words' do dataset
df_sem_stop_words <- anti_join(df_token, stop_words)

# Calculando a frequencia das palavras
df_freq <- df_sem_stop_words %>% count(word, sort = T)

df_sem_stop_words %>%
  count(word, sort = TRUE) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col(fill = 'darkblue') +
  theme_bw()
