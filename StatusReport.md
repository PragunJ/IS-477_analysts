## 1. Project Overview

Our project analyzes the relationship between **energy production and economic development**, measured by GDP per capita across regions. By integrating datasets from the United Nations Data Portal, we aim to understand how different aspects of energy availability and usage are associated with economic output.

At this stage, our project has progressed beyond data preparation and into the analysis phase. We have completed data collection, cleaning, and integration, and have already conducted preliminary exploratory analysis and regression modeling. Our current focus is on interpreting results and refining our findings.

## 2. Current Progress

### Dataset Collection (Completed)

We successfully collected the required datasets from the UN Data Portal, including:

- Energy Production, Trade and Supply dataset  
- GDP and GDP per Capita dataset  

These datasets are stored in the repository under the `Datasets/` folder. We used direct links to ensure reproducibility and consistency across team members.

### Data Cleaning (Completed)

We completed data cleaning to ensure consistency and usability across datasets. The main steps included:

- Removing extra header rows within the datasets  
- Standardizing column names (e.g., country, year, series, value)  
- Converting values into numeric format (removing commas and handling missing values)  
- Filtering invalid or incomplete rows  

These steps are implemented in our data processing scripts and notebook.


### Data Integration (Completed)

We successfully integrated the datasets using common identifiers:

- Country code  
- Year  

To improve clarity and reduce noise, we transformed the data from country-level to **continent-level aggregation**. We mapped country codes to continents and used pivot tables to restructure the datasets into a wide format, where each variable is aligned by continent and year.

We then merged the energy and GDP datasets into a single structured dataset, which is used for all subsequent analysis.


### Exploratory Data Analysis (Completed)

We conducted exploratory data analysis to better understand the relationships between variables.

We generated a **correlation matrix** to examine relationships between GDP and energy-related variables. The results show strong correlations between GDP per capita and several energy indicators, particularly energy production and energy per capita.

We also created **time-series visualizations** of GDP per capita across continents. These plots show clear differences in economic development patterns, with North America and Europe having consistently higher GDP per capita, while other regions show different growth trends.


### Statistical Analysis (Completed)

We conducted a multiple linear regression analysis to examine how energy variables relate to GDP per capita.

The model includes:
- Energy production  
- Energy supply  
- Energy per capita  

The regression results show a strong model fit (**R² ≈ 0.85**), indicating that energy-related variables explain a large portion of variation in GDP per capita.

**Key findings include:**
- Energy production has a **positive** relationship with GDP per capita  
- Energy per capita also shows a **strong** positive effect  
- Energy supply has a **negative** coefficient, suggesting potential inefficiencies or structural differences across regions  

These results suggest that both the availability and efficiency of energy play important roles in economic development.


### Visualization (Completed)

We created multiple visualizations to support our analysis:

- Correlation heatmap to illustrate relationships between variables  
- Time-series line plots of GDP per capita by continent  
- Scatter plot of Energy Supply vs GDP

These visualizations help highlight both the strength of relationships and differences across regions.


### Interpretation & Reporting (In Progress)

We are currently interpreting our results and refining our conclusions. This includes analysing statistical findings with economic reasoning and preparing the final report.


## 3. Updated Timeline

| Task | Status | Completion |
|------|--------|-----------|
| Dataset Collection | Completed | Week 7 |
| Data Cleaning | Completed | Week 9 |
| Data Integration | Completed | Week 10 |
| Exploratory Analysis | Completed | Week 12 |
| Statistical Analysis | Completed | Week 13 |
| Visualization | Completed | Week 13 |
| Interpretation | In Progress | Week 13 |
| Final Report | Not Started | Week 14 |


## 4. Changes to Project Plan

Based on our progress, we made several adjustments to improve feasibility and clarity.

Initially, our project included multiple datasets and variables, such as energy, employment, agriculture, and GDP. However, we found this scope to be too broad and difficult to manage within the given timeline.

To address this, we reduced the scope to focus only on **energy production and GDP per capita**, which are the most directly relevant variables.

In addition, we shifted from country-level analysis to **continent-level aggregation**. This decision helped reduce noise in the data and allowed us to focus on broader regional patterns, making the analysis more structured and interpretable.

These changes significantly improved the clarity and manageability of the project.


## 5. Challenges and Solutions

### Data Formatting Issues

The UN datasets contained repeated headers and inconsistent formatting.

**Solution:**  
We cleaned the data by standardizing columns, removing duplicate rows, and converting data types.

### Encoding Errors

We encountered encoding issues when loading the CSV files.

**Solution:**  
We resolved this by specifying the correct encoding format when reading the files.

### Data Complexity

The datasets included many irrelevant variables and aggregate categories.

**Solution:**  
We filtered the datasets to retain only relevant variables and removed aggregate entries.


### Scope Adjustment

The initial scope was too broad and difficult to execute.

**Solution:**  
After discussion with TA, we narrowed the focus to key variables and used continent-level aggregation.


## 6. Team Member Contributions

#### Cynthia (Data Analysis & Visualization)

- Refined research focus and project direction  
- Designed analytical approach (regression, visualization)  
- Interpreted correlation and regression results  
- Contributed to report writing and structuring insights  

#### PJ (Data Engineering)

- Collected datasets from the UN Data Portal  
- Implemented data cleaning and preprocessing  
- Developed merging and transformation workflow  
- Prepared final dataset for analysis  


## Next Steps

Our next steps include:

- Finalizing interpretation of regression results  
- Refining visualizations for clarity  
- Writing the final project  

## Conclusion

Overall, our project is progressing well and has reached the analysis stage. We have successfully completed data preparation and conducted meaningful statistical analysis. Our preliminary findings suggest a strong relationship between energy and economic development, and we are now focused on refining and presenting these results clearly.
