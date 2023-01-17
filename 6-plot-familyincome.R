library(ggplot2)
library(tidyverse)
library(ggpubr)
library(ggrepel)

data <- read.csv("cleandata.csv")

plot3 <- ggplot(data, 
       aes(x = INDFMINC, #Family income
           color = RIDRETH1))  + 
  geom_bar(alpha = 2/5, position = "dodge")+
  facet_grid(DMDCITZN ~ DMDMARTL) +
  labs(title = "Family Income histograms by Gender and Marriage",
       x = "Family Income")
plot3 %>% ggsave(filename="results/fig-simple6.png", plot=.)