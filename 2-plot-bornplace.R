library(ggplot2)
library(tidyverse)
library(ggpubr)
library(ggrepel)

data <- read.csv("cleandata.csv")

plotdata2 <- data %>%
  count(DMDBORN) %>%
  arrange(desc(DMDBORN)) %>%
  mutate(prop = round(n*100/sum(n), 1),
         lab.ypos = cumsum(prop) - 0.5*prop)

plotdata2$label <- paste0(round(plotdata2$prop), "%")

p2 <- ggplot(plotdata2, 
             aes(x = "", 
                 y = prop, 
                 fill = DMDBORN)) +
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
  labs(title = "Participants by Born Place")

#Born place
p5 <- ggplot(data,mapping = aes(x = RIDAGEYR, fill = DMDBORN )) + 
  geom_bar(alpha = 2/5, position = "stack")


distr2 <- ggarrange(p2, p5,
                    ncol = 1, nrow = 2)
distr2 %>% ggsave(filename="results/fig-simple2.png", plot=.)
