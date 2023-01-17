library(ggplot2)
library(tidyverse)
library(ggpubr)
library(ggrepel)

data <- read.csv("cleandata.csv")
plotdata1 <- data %>%
  count(RIDRETH1) %>%
  arrange(desc(RIDRETH1)) %>%
  mutate(prop = round(n*100/sum(n), 1),
         lab.ypos = cumsum(prop) - 0.5*prop)

plotdata1$label <- paste0(
  round(plotdata1$prop), "%")

p1 <- ggplot(plotdata1, 
             aes(x = "", 
                 y = prop, 
                 fill = RIDRETH1)) +
  geom_bar(width = 1, 
           stat = "identity", 
           color = "black",
           alpha = 2/5) +
  geom_text_repel(aes(y = lab.ypos, label = label), 
                  color = "black") +
  coord_polar("y", 
              start = 0, 
              direction = -1) +
  theme_void() +
  labs(title = "Participants by race")

#Race
p4 <- ggplot(data, mapping = aes(x = RIDAGEYR , fill = RIDRETH1))+
  
  geom_bar(alpha = 2/5, position = "stack")

#Combine two figure
distr1 <- ggarrange(p1, p4,
                    ncol = 1, nrow = 2)
distr1 %>% ggsave(filename="results/fig-simple1.png", plot=.)
