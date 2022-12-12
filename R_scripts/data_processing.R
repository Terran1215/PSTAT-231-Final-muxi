milk=read_csv(file = "milk.csv",show_col_types = FALSE)
milk=milk %>% filter(Colour!="254")
milk %>% 
  select(where(is.numeric)) %>% 
  cor(use = "complete.obs") %>% 
  corrplot(type = "lower")
milk=milk %>% 
  mutate(Taste = factor(Taste),Odor = factor(Odor),Fat = factor(Fat),Turbidity =factor(Turbidity),Colour = factor(Colour))%>% 
  mutate(Grade = factor(Grade, levels = c("high","medium", "low")))
