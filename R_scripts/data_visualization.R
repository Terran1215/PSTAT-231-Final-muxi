milk %>% 
  ggplot(aes(x = forcats::fct_infreq(as.factor(milk$Colour)))) +
  geom_bar() +
  coord_flip()
ggplot(milk, aes(reorder(Grade, Colour), Colour,fill = 'color')) +
  geom_boxplot(varwidth = TRUE) + 
  coord_flip() 
milk %>% 
  ggplot(aes(x = pH, y = Grade, fill = 'color')) + 
  geom_boxplot() +
  labs(y = "Grade", x = "pH") +
  theme_bw()
milk %>% 
  ggplot(aes(x = Temprature, y = Grade, fill = 'color')) + 
  geom_boxplot() +
  labs(y = "Grade", x = "Temprature") +
  theme_bw()
milk %>% 
  select(where(is.numeric)) %>% 
  cor(use = "complete.obs") %>% 
  corrplot(type = "lower")