install.packages(c('car', 'corrplot', 'caret', 'carData', 'ggplot2', 'lattice'))

library(car)
library(corrplot)
library(caret)
library(carData)
library(ggplot2)
library(lattice)


house <- read.csv(file = 'ameshousing3.csv')
head(house)
str(house)


house_reduced <- house[, c('Lot_Area', 'Year_Built', 'Gr_Liv_Area',
                           'Garage_Area', 'Yr_Sold', 'SalePrice',
                           'Basement_Area', 'Deck_Porch_Area', 'Age_Sold')]


corr_matrix <- cor(house_reduced, use = "complete.obs")
corrplot(corr_matrix, method = "color", tl.cex = 0.8)


# Model 1: Simple regression
model_1 <- lm(SalePrice ~ Gr_Liv_Area, data = house_reduced)
summary(model_1)

# Visualize Model 1
plot(SalePrice ~ Gr_Liv_Area, data = house_reduced,
     col = "blue4", main = "House Price vs. Ground Living Area",
     xlab = "Total Ground Living Area", ylab = "Sale Price")
abline(model_1, col = "red4", lwd = 2)

# Residual diagnostics
plot(model_1, 1) 
plot(model_1, 2)  
plot(model_1, 3) 

# Progressive model building
model_2 <- lm(SalePrice ~ Gr_Liv_Area + Garage_Area, data = house_reduced)
model_3 <- lm(SalePrice ~ Gr_Liv_Area + Garage_Area + Basement_Area, data = house_reduced)
model_4 <- lm(SalePrice ~ Gr_Liv_Area + Garage_Area + Basement_Area + Age_Sold, data = house_reduced)
model_5 <- lm(SalePrice ~ Gr_Liv_Area + Age_Sold + Basement_Area, data = house_reduced)


summary(model_2)
summary(model_3)
summary(model_4)
summary(model_5)

# Multicollinearity check
vif(model_4)

# Pairwise relationships
pairs(house_reduced[, c("SalePrice", "Gr_Liv_Area", "Garage_Area", "Basement_Area", "Age_Sold")],
      lower.panel = NULL, pch = 19, cex = 0.2)

# Save correlation plot
png("outputs/correlation_plot.png")
corrplot(corr_matrix)
dev.off()

# Logistic Regression: CHD Dataset
CHD <- read.csv(file = 'CHD.csv')
head(CHD)
str(CHD)

# Logistic Model 1: Full model
model_logistic_1 <- glm(chd ~ sbp + tobacco + ldl + adiposity + famhist + 
                          typea + obesity + alcohol + age,
                        data = CHD, family = "binomial")
summary(model_logistic_1)

# Logistic Model 2: Reduced model
model_logistic_2 <- glm(chd ~ tobacco + ldl + famhist + typea + age,
                        data = CHD, family = "binomial")
summary(model_logistic_2)

# Variable importance
importance <- varImp(model_logistic_2, scale = FALSE)
importance

# Logistic Model 3: Minimal model
model_logistic_3 <- glm(chd ~ famhist + age, data = CHD, family = "binomial")
summary(model_logistic_3)

# Predictions and probabilities
CHD$probs <- predict(model_logistic_2, newdata = CHD, type = "response")
CHD$logits <- log(CHD$probs / (1 - CHD$probs))

# Diagnostic plots
plot(model_logistic_2, which = 4, id.n = 3)

# Check multicollinearity
vif(model_logistic_2)

# Logistic Regression Visualization
ggplot(CHD, aes(x = age, y = chd)) +
  geom_point(color = "blue") +
  stat_smooth(method = "glm", color = "red4", se = FALSE,
              method.args = list(family = binomial)) +
  labs(title = "CHD Probability by Age",
       x = "Age", y = "CHD (0/1)")


