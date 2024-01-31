# input file: RPF_*_Rep*_Codon_occupancy.txt
# output file: A_site_codon_occupancy.pdf

#setwd("")

## Load packages
library(tidyverse)
library(MASS)
library(car)

## Datasets
df_1 <- read.table("RPF_WT_Rep1_Codon_occupancy.txt",
                   header = F,
                   sep = "\t")

df_2 <- read.table("RPF_WT_Rep2_Codon_occupancy.txt",
                   header = F,
                   sep = "\t")

df_3 <- read.table("RPF_KO_Rep1_Codon_occupancy.txt",
                   header = F,
                   sep = "\t")

df_4 <- read.table("RPF_KO_Rep2_Codon_occupancy.txt",
                   header = F,
                   sep = "\t")

## Function to add column names
process_data <- function(input_df, sample) {
  colnames(input_df) <- c("Codon", "Occupancy")
  input_df$Sample <- sample
  input_df
}

df_1 <- process_data(df_1, "WT_Rep1")
df_2 <- process_data(df_2, "WT_Rep2")
df_3 <- process_data(df_3, "KO_Rep1")
df_4 <- process_data(df_4, "KO_Rep2")

## Merging datasets
data_wt <- inner_join(df_1, df_2, by = "Codon", suffix = c("_1", "_2"))
data_ko <- inner_join(df_3, df_4, by = "Codon", suffix = c("_1", "_2"))

## Take average of the two samples
data_wt$WT <- (data_wt$Occupancy_1 + data_wt$Occupancy_2) / 2
data_ko$KO <- (data_ko$Occupancy_1 + data_ko$Occupancy_2) / 2

## Extract the relevant columns
data_wt <- data_wt[ , c(1, 6)]
data_ko <- data_ko[ , c(1, 6)]

## Merge KO and WT datasets
data_plot <- inner_join(data_wt, data_ko, 
                        by = "Codon", 
                        suffix = c("", ""))

## Calculate normalized occupancy
data_plot$Norm_Occupancy_KO <- data_plot$KO / data_plot$WT

## Extract the relevant columns
data_plot <- data_plot[ , c(1, 4)]

#############################
##Standard deviation method##
#############################

mean_value <- mean(data_plot$Norm_Occupancy_KO)
std_dev <- sd(data_plot$Norm_Occupancy_KO)

# Define the thresholds as two standard deviations from the mean
threshold_high <- mean_value + 2 * std_dev
threshold_low <- mean_value - 2 * std_dev

# Filter abnormal high and low values
abnormal_high_values <- subset(data_plot, Norm_Occupancy_KO > threshold_high)
abnormal_low_values <- subset(data_plot, Norm_Occupancy_KO < threshold_low)

# Combine abnormal values
abnormal_values <- rbind(abnormal_high_values, abnormal_low_values)

print(abnormal_values)

###########################################################
##checking for normality of codon occupancy using QQ plot##
###########################################################

fit <- fitdistr(data_plot$Norm_Occupancy_KO, "normal")
qqPlot(data_plot$Norm_Occupancy_KO, dist = "norm", mean = fit$estimate["mean"], sd = fit$estimate["sd"], xlab= "Theor. quantiles (norm)", ylab = "Empirical quantiles") 

############################
##Percentile ranges method##
############################

# Calculate the percentiles
percentile_5 <- quantile(data_plot$Norm_Occupancy_KO, probs = 0.05)
percentile_95 <- quantile(data_plot$Norm_Occupancy_KO, probs = 0.95)

# Filter abnormal values based on percentiles
abnormal_low_values <- subset(data_plot, Norm_Occupancy_KO < percentile_5)
abnormal_high_values <- subset(data_plot, Norm_Occupancy_KO > percentile_95)

# Combine abnormal values
abnormal_values <- rbind(abnormal_low_values, abnormal_high_values)

print(abnormal_values)

#################################
length(data_plot$Norm_Occupancy_KO[data_plot$Norm_Occupancy_KO < 1])
length(data_plot$Norm_Occupancy_KO[data_plot$Norm_Occupancy_KO > 1])
 
#plot
pdf("A_site_codon_occupancy.pdf",width = 8, height = 10)
ggplot(data_plot, aes(x = Norm_Occupancy_KO, y = Codon)) +
  geom_point(color = "#dd1c77") +
  xlab("Codon occupancy (KO/WT)") +
  ylab("Codons") +
  theme_bw() +
  # Add vertical lines
  geom_vline(xintercept = percentile_5, linetype = "dashed", color = "black") +
  geom_vline(xintercept = percentile_95, linetype = "dashed", color = "black")
dev.off()


#saving session information to file
session_info <- capture.output(sessionInfo())
writeLines(session_info, "ribo_seq_session_info.txt")
