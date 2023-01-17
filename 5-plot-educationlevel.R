library(ggplot2)
library(tidyverse)
library(ggpubr)
library(ggrepel)

data <- read.csv("cleandata.csv")

g <- ggplot(data, 
            aes(x = RIDAGEYR, 
                y = DMDEDUC3,
                color = RIDRETH1,
                alpha = 2/5,
                shape = RIAGENDR)) +
  geom_point(size = .5 )+
  geom_smooth(method = "lm",
              formula = y ~ poly(x,2),
              se = FALSE, 
              size = .5)+
  
  labs(title = "Education level by gender, race, and ages",x = "Age", y = "Education Levels")
plot2 <- g + xlim(c(14, 85)) + ylim(c(0, 22))

plot2 %>% ggsave(filename="results/fig-simple5.png", plot=.)