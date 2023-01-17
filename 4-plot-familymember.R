library(ggplot2)
library(tidyverse)
library(ggpubr)
library(ggrepel)

data <- read.csv("cleandata.csv")

plot1 <- ggplot(data, aes(x=DMDMARTL, y = DMDFMSIZ)) +
geom_line(color="grey") +
geom_point(color="#99CCFF", position = "jitter", size = 0.5) +
facet_wrap(~RIDRETH1) +
theme_minimal(base_size = 9) +
theme(axis.text.x = element_text(angle = 45,
                                 hjust = 1)) +
labs(title = "Total number of family members Changes in different ages",
     x = "Age",
     y = "Total number of family members") 
plot1 %>% ggsave(filename="results/fig-simple4.png", plot=.)
