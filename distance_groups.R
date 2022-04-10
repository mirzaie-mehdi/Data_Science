ibrary(dplyr)

df <- read.table(text = "
  ID  GroupID X        Y
  1   a      772.7778 226.5
  1   a      806.5645 35.3871
  1   a      925.5714 300.9286
  1   b      708.0909 165.5455
  1   b      630.8235 167.4118
  2   a      555.3333 151.875
  2   a      732.8947 462.3158", header = T, stringsAsFactors = F)

df %>%
  group_by(ID, GroupID) %>%
  mutate(rows = row_number()) %>%
  left_join(df, by = c('ID', 'GroupID')) %>%
  rowwise() %>%
  mutate(Distance = ifelse(dist(rbind(c(X.x, Y.x), c(X.y, Y.y))) != 0,
                           dist(rbind(c(X.x, Y.x), c(X.y, Y.y))),
                           NA)) %>%
  filter(rows == 1) %>%
  select(ID, GroupID, X = X.y, Y= Y.y, Distance)