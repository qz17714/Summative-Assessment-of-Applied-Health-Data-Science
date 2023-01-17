library(ggplot2)
library(tidyverse)
library(ggpubr)
library(ggrepel)

data <- read.csv("cleandata.csv")

plotdata3 <- data %>%
  count(DMDMARTL) %>%
  arrange(desc(DMDMARTL)) %>%
  mutate(prop = round(n*100/sum(n), 1),
         lab.ypos = cumsum(prop) - 0.5*prop)

plotdata3$label <- paste0(round(plotdata3$prop), "%")

p3 <- ggplot(plotdata3, 
             aes(x = "", 
                 y = prop, 
                 fill = DMDMARTL)) +
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
  labs(title = "Participants by Martial status")

#Martial status
p6 <- ggplot(data,mapping = aes(x = RIDAGEYR, fill = DMDMARTL )) + 
  geom_bar(alpha = 2/5, position = "stack")

distr3 <- ggarrange(p3, p6,
                    ncol = 1, nrow = 2)
distr3 %>% ggsave(filename="results/fig-simple3.png", plot=.)
