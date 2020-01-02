#===
# SETUP
#===

#install.packages("corrplot")
#install.packages("stargazer")

library(stargazer)
library(reshape2)
library(dplyr)
library(tidyverse)
library(ggplot2)
library("viridis")
library(corrplot)
library(ggplot2)
library(fitdistrplus)
library(stargazer)

#===
# LOAD DATA
#===

df <- read.csv("./output/lsoa_df.csv") %>%
  dplyr::select(run_count,imd, perc_bme, mn_dstn,  
                total_pop, pop_density,perc_non_working_age) %>% 
  mutate(run_rate = run_count/total_pop * 1000/52)

#===
# DESCRIPTIVE STATISTICS - TABLE 2
#===
stargazer(df %>% mutate(perc_non_working_age = perc_non_working_age*100,
                        perc_bme = perc_bme*100), 
          type = "latex", style = "aer",
          header = FALSE, 
          title="", 
          median = T,
          digits=1, digits.extra = 2, #initial.zero = FALSE,
          covariate.labels=c("Number of Finishers",
                             "IMD Score",
                             "Ethnic Density",
                             "Access (km)",
                             "Population",
                             "Population Density",
                             "Non-working age",
                             "Participation Rate"))

#===
# CORRELATION PLOT - UNUSED
#===
cor_mat <-  read.csv("./output/lsoa_df.csv") %>%
  dplyr::select(run_count,imd, perc_bme, mn_dstn,  
                total_pop, pop_density,perc_non_working_age) %>%
  cor

rownames(cor_mat) <-  colnames(cor_mat) <- c("Participation","IMD","Ethnic Density","Access","Total Pop","Pop Density","% Non Working") #substr(colnames(cor_mat),1,20)

corrplot(corr = cor_mat,
         addCoef.col = "black",
         type = "upper") 

#===
# COLOUR PLOT - FIGURE 1
#===

# read in data from df
df <- read.csv("./output/lsoa_df.csv") %>% 
      mutate(urban = if_else(urban==TRUE, "Urban", "Rural"),
             urban = factor(urban, levels = c("Urban","Rural")),
             run_rate = run_count/total_pop/52*1000,
             imd_dec = cut(x = imd,
                     breaks = seq(0,100,10),        #  quantile(imd,seq(0,1,0.1)),
                     ordered_result = T,
                     labels = F)*10,
             bme_dec= cut(x = perc_bme,
                    breaks = seq(0,1,0.1),                  # quantile(perc_bme,seq(0,1,0.1)),
                    ordered_result = T,
                    labels = F)*10)%>%
  
  melt(id.vars = c("code","imd_dec","bme_dec","urban"),
       measure.vars ="run_rate", 
       value.name = "run_rate") %>%
  
  dplyr::select(imd_dec,bme_dec,run_rate,urban)

# aggregate data by deprivation and ethnic density
df <- aggregate(run_rate ~ bme_dec + imd_dec + urban, #+ #pop_density_bins, 
                data = df, 
                FUN= "mean")

# create colour plot
plot1 <- (ggplot(data = df,
                 aes(as.factor(bme_dec), as.factor(imd_dec), fill= run_rate)) + 
            geom_tile()+
            theme_classic()+
            scale_fill_viridis(discrete=FALSE,name = "Participation \n Rate") +
            xlab("Ethnic Density (%)")+
            ylab("Index of Multiple Deprivation (0-100)")  + 
            facet_wrap(~urban, nrow = 1) +
            labs(caption="Sources: Office for National Statistics \n and parkrunUK")+
            theme(legend.position = c(0.92,0.5))+
            theme(axis.text.x = element_text(hjust = -0),
                  axis.text.y = element_text(vjust = -2),
                  axis.ticks.x = element_blank(),
                  axis.ticks.y = element_blank())+
            annotate("text", x=8.5,y=9.5, label = "Most Deprived & \n Highest Ethnic Density", color = "black", size = 2, fontface = "bold")) 
#NULL

plot1

ggsave(filename = "./output/colour_plot.png",plot = plot1,device = "png")


#===
# POISSON REGRESSION MODEL - FIGURE 2
#===

df <- read.csv("./output/lsoa_df.csv")

df$pop_density = log(df$pop_density )  # tranforming pop_density to log scale

#===
# Model 1: Poisson model IMD and controls.
#===


model1 <- glm(run_count ~ imd  +  pop_density + mn_dstn + perc_non_working_age,
              data = df,
              family = poisson(link="log"),
              offset = log(total_pop))


# stargazer(model1,ci=TRUE, ci.level=0.95)

x = summary(model1)
r1.1 = 1-((x$deviance-length(coef(x)[,1]))/x$null.deviance)
# r1.1

#===
# Model 2: Poisson model Ethnic density and controls.
#===

model2 <- glm(run_count ~  perc_bme +  pop_density + mn_dstn + perc_non_working_age,
              data = df,
              family = poisson(link="log"),
              offset = log(total_pop))

# stargazer(model2,ci=TRUE, ci.level=0.95)

x = summary(model2)
r1.2 = 1-((x$deviance-length(coef(x)[,1]))/x$null.deviance)
# r1.2


#===
# Model 3: Poisson model with IMD and Ethnic density and controls
#===

model3 <-  glm(run_count ~ imd + perc_bme +  pop_density + mn_dstn + perc_non_working_age,
               data = df,
               family = poisson(link="log"),
               offset = log(total_pop))

# stargazer(model3,ci=TRUE, ci.level=0.95)

x = summary(model3)
r1.3 = 1-((x$deviance-length(coef(x)[,1]))/x$null.deviance)


# PLOT stargazer plot of models
stargazer(model1, model2, model3,
          header = FALSE,
          column.labels	= c("Model 1","Model 2","Model 3"),
          ci=FALSE, ci.level=0.95, #font.size= 9, 
          title="Poisson Log-link GLM Results",
          dep.var.labels = "Participation",
          covariate.labels = c("IMD Score",
                               "Ethnic-Density",
                               "Pop Density",
                               "Distance(km)",
                               "Non-working-age"))


