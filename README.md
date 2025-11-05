# Linear and Logistic Regression Analysis in R

A portfolio project demonstrating end-to-end **predictive modeling** using **R**.  
The project covers both **linear regression** (predicting house prices) and **logistic regression** (predicting coronary heart disease).

---

## Datasets
1. **Ames Housing Dataset** – Predicts `SalePrice` based on property features.
2. **CHD Dataset** – Predicts the probability of coronary heart disease (`chd`).

---

## Techniques Used
- Data exploration & visualization
- Correlation analysis (`corrplot`)
- Linear regression model building (`lm`)
- Logistic regression (`glm`)
- Model diagnostics (`plot`, `vif`)
- Feature importance (`caret`)
- Visualization with `ggplot2`

---

## Packages Required
```r
install.packages(c('car', 'corrplot', 'caret', 'carData', 'ggplot2', 'lattice'))
