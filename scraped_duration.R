library(readr)
library(plotly)
library(magrittr)

# Defense of the Ancient 2

df_dota <- read_csv("C:/Users/Honza/Desktop/scraped_duration_dota.csv") %>%
  mutate(odds_diff = abs(home-away))

ply_dota <-
  plot_ly(
    df_dota,
    x = ~odds_diff,
    y = ~est_duration,
    name = 'Kiev',
    type = 'scatter',
    mode = 'markers',
    color = ~tournament
  )
  # layout(yaxis = list(range = c(28,38), title = 'Estimated_game_duration'), xaxis = list(title = 'Odds_difference')) %>%
  # add_trace(x = df_dota$odds_diff_prodota, y = df_dota$Est_duration_prodota, name = 'Prodota', 
  #           marker = list(color = 'white',line = list(color = 'purple',width = 1.2))) %>%
  # add_trace(x = df_dota$odds_diff_dpl, y = df_dota$Est_duration_dpl, name = 'DPL', 
  #           marker = list(color = 'white',line = list(color = 'blue',width = 1.2)))
    
# League of Legends

df_lol <- read_csv("C:/Users/Honza/Desktop/scraped_duration_lol.csv")

df_lol$odds_diff_LCK <- abs(df_lol$Away_LCK - df_lol$Home_LCK)
df_lol$odds_diff_LCS <- abs(df_lol$Away_LCS - df_lol$Home_LCS)
# df_lol$odds_diff_dpl <- abs(df_lol$Away_dpl - df_lol$Home_dpl)

ply_lol <-
  plot_ly(
    df_lol,
    x = df_lol$odds_diff_LCK,
    y = df_lol$Est_duration_LCK,
    name = 'LCK',
    type = 'scatter',
    mode = 'markers',
    marker = list(
      color = 'white',
      line = list(color = ~Tournament,
                  width = 1.2))
  ) %>%
  layout(yaxis = list(range = c(34,38), title = 'Estimated_game_duration'), xaxis = list(title = 'Odds_difference')) %>%
  add_trace(x = df_lol$odds_diff_LCS, y = df_lol$Est_duration_LCS, name = 'LCS', 
            marker = list(color = 'white',line = list(color = 'grey',width = 1.2)))

lm(Est_duration_kiev~abs(Home_kiev - Away_kiev), df_dota) %>% summary()

df_test <- read_csv("C:/Users/Honza/Desktop/scraped_duration_test.csv")

df_test$odds_diff <- abs(df_test$Away - df_test$Home)

ply_test <-
  plot_ly(
    data = df_test,
    x = ~odds_diff,
    y = ~Est_duration,
    type = 'scatter',
    mode = 'markers',
    color = ~Tournament
  )
