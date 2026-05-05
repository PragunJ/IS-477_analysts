# A Cross-Continental Analysis on Energy Production and Economic Development

## Contributors

- **PJ**: Data Engineer
- **Cynthia**:
 Data Analyst & Visualization

### Contribution Statement

Because both team members typically authored content locally before pushing to GitHub, the Git commit history alone may not fully reflect each member's contributions. The detailed division of work was as follows:

- **PJ** led data acquisition (programmatic CSV download from UNdata), data integrity checks (SHA-256), data cleaning (string-to-numeric conversion, continental aggregate filtering, long-to-wide pivoting), dataset integration (merge on continent + year), and workflow automation (`run_all.sh` script, environment specification).
- **Cynthia** led exploratory data analysis, the OLS regression model, correlation matrix and heatmap visualization, time-series and scatter plot generation, interpretation of statistical results, and the Findings, Future Work, and Challenges sections of this report.
- Both members jointly authored the Summary, Data Profile, Data Quality, and Data Cleaning sections, and reviewed the final report end-to-end.

---

## Summary

This project investigates the relationship between energy production, energy supply, and economic development across the world's major continental regions over time. Access to energy is widely regarded as one of the most essential enablers of industrial output, transportation, and living standards, yet the exact nature of its relationship with economic growth is still an open question.

Our central research question is: **How does energy production and supply relate to GDP per capita across continental regions, and how has this relationship evolved over the years?**

We combined two datasets from the United Nations Data Portal (UNdata): one containing GDP and GDP per capita figures (UN Statistical Yearbook series SYB68_230, with continental aggregates available for 1995, 2005, 2010, 2015, 2020, 2022, and 2023), and another containing regional energy output, trade, and overall supply (series SYB68_263, with continental aggregates available for 1995, 2000, 2005, 2010, 2015, 2020, 2021, and 2022). We were able to combine the two datasets using continent codes as common identifiers because they both use identical UN country and regional classification codes. Africa, Asia, Europe, Latin America and the Caribbean, North America, and Oceania are the six main continental aggregates that we investigated. These pre-aggregated regional totals are ideal for multi-regional comparison because they are standardized internally and immediately contained in the UN CSV files alongside individual nation rows.

This project follows the **data lifecycle model** introduced in Module 1, progressing through plan → acquire → process (clean and integrate) → analyze → preserve → publish. Each phase is reflected in a corresponding artifact in the repository: the project plan (`ProjectPlan.md`), acquisition and integrity checks (in the notebook and `checksums.txt`), cleaning and integration (in the notebook), analysis and visualizations (in the notebook), and preservation/publication (this README, `metadata.json`, and the `Final_Script.ipynb`).

After cleaning and integrating the datasets, we conducted exploratory data analysis, computed Pearson correlations among all numeric variables, and produced a correlation heatmap. We also fitted an Ordinary Least Squares (OLS) regression model predicting GDP per capita from three energy predictors: energy supply per capita (GJ), total energy supply (PJ), and primary energy production (PJ). In addition, we derived a new variable, energy intensity, defined as energy supply per billion USD of GDP. We did this to examine how efficiently each region converts energy into monetary output over time.

Our regression model achieved an R² of **0.852** and an adjusted R² of 0.839, with an F-statistic of 61.58, indicating that the model explains approximately 85% of the variance in GDP per capita across continent-year observations. Energy per capita emerged as the strongest individual predictor, with a coefficient of approximately +214.87, suggesting that each additional gigajoule of energy supply is associated with roughly $215 more in GDP per capita, holding other variables constant.

North America consistently shows the highest GDP per capita throughout the study period, rising from $27,704 in 1995 to $74,063 in 2022, alongside the highest energy per capita figures of 272 to 324 GJ per person. Africa has the lowest values on both dimensions, with GDP per capita ranging from $826 to $2,013 and energy per capita remaining essentially flat at 22 to 24 GJ. Asia shows the most dramatic absolute growth, with GDP per capita nearly tripling from $2,680 to $8,022 and total energy supply expanding from 124,229 PJ to 325,744 PJ over the same period. Across all regions, energy intensity declined substantially between 1995 and 2022, suggesting that economic growth has increasingly outpaced raw energy consumption, consistent with improvements in energy efficiency and structural shifts toward service-oriented economies.

---

## Data Profile

### Dataset 1: Energy Production, Trade and Supply

- **Source:** United Nations Statistics Division, UNdata portal
- **Series identifier:** SYB68_263_202511
- **URL:** https://data.un.org/_Docs/SYB/CSV/SYB68_263_202511_Production,%20Trade%20and%20Supply%20of%20Energy.csv
- **File location in repository:** `Datasets/Energy Production and Supply Data.csv`
- **Approximate size:** 1.49 MB
- **SHA-256:** `425460565f23d953116e9233a3548d6e51ee2d4b14bc3348e6886aee3119ece2`

**Structure:** Each row represents one observation for a single country or regional aggregate, for one year, on one energy series (indicator). The dataset is in long format. There are multiple rows per country-year, one for each series.

| Column | Type | Description |
|---|---|---|
| country_code | integer | UN numeric country/region code (M49 standard) |
| country_name | string | Name of country or region |
| year | integer | Reference year |
| series | string | Energy indicator (see below) |
| value | string (→ float) | Measured value; may include comma thousands separators |
| footnotes | string | Footnote markers (e.g., estimation notes) |
| source | string | UN source reference |

**Series (indicator variables) present:**
- Primary energy production (petajoules)
- Net imports [Imports − Exports − Bunkers] (petajoules)
- Changes in stocks (petajoules)
- Total supply (petajoules)
- Supply per capita (gigajoules)

**Temporal coverage:** Continental aggregates are available for 8 discrete time points: **1995, 2000, 2005, 2010, 2015, 2020, 2021, 2022**.

**Geographic coverage:** 200+ countries and territories, plus six continental aggregates (codes 2, 9, 21, 142, 150, 419).

**Relationship to research question:** This dataset provides the primary independent variables for our analysis, total energy supply, energy supply per capita, and primary energy production, which we use to predict and explain GDP per capita across regions.

**Ethical and legal constraints:** UNdata is provided free of charge under the [UNdata Terms of Use](https://data.un.org/Host.aspx?Content=UNdataUse). The data may be copied, duplicated, and further distributed provided that UNdata is cited as the reference; there are no non-commercial restrictions, only an attribution requirement, which we satisfy throughout this repository. The underlying national statistics are compiled from member-state submissions, meaning they inherit any biases or definitional inconsistencies in national reporting systems. No personally identifiable information is present.

### Dataset 2: GDP and GDP Per Capita

- **Source:** United Nations Statistics Division: UNdata portal
- **Series identifier:** SYB68_230_202511
- **URL:** https://data.un.org/_Docs/SYB/CSV/SYB68_230_202511_GDP%20and%20GDP%20Per%20Capita.csv
- **File location in repository:** `Datasets/GDP and GDP Per Capita 2025.csv`
- **Approximate size:** 1.44 MB
- **SHA-256:** `8091d7ba3b94ad60477a66cd41fd7b0a1dd1cafd5014ccda74f6c6032e9da9ac`

**Structure:** Identical long format to the energy dataset, one row per country-year-series combination.

| Column | Type | Description |
|---|---|---|
| country_code | integer | UN numeric country/region code (shared with energy dataset) |
| country_name | string | Name of country or aggregate region |
| year | integer | Reference year |
| series | string | GDP indicator (see below) |
| value | string (→ float) | Measured value; may include comma thousands separators |
| footnotes | string | Footnote markers |
| source | string | UN source reference |

**Series (indicator variables) present:**
- GDP in current prices (millions of US dollars)
- GDP in constant 2015 prices (millions of US dollars)
- GDP per capita (US dollars)
- GDP real rates of growth (percent)

**Temporal coverage:** Continental aggregates are available for 7 discrete time points: **1995, 2005, 2010, 2015, 2020, 2022, 2023**.

**Geographic coverage:** 200+ countries and territories, plus the same six continental aggregates.

**Relationship to research question:** This dataset provides both the dependent variable (GDP per capita) and supplementary GDP measures (current-price total GDP, constant-price GDP, growth rates) used in the analysis.

**Ethical and legal constraints:** Same UNdata Terms of Use as the energy dataset. GDP figures are denominated in US dollars and deflated to 2015 prices for real comparisons; cross-country comparisons in current prices should be interpreted with caution due to exchange rate and PPP differences. No personally identifiable information is present.

### Integration

The two datasets share the `country_code` and `year` columns, enabling a merge on continent + year after filtering to continental aggregate codes. Both datasets use identical UN numeric codes for the six continental regions, which provides a reliable join key with no ambiguity. The two year sets are not identical: the GDP dataset includes 2023 (not present in energy), while the energy dataset includes 2000 and 2021 (not present in GDP). The intersection consists of six common years: **1995, 2005, 2010, 2015, 2020, 2022**. An inner join produces a wide-format table with 36 rows (6 continents × 6 years) and separate columns for each GDP and energy series.

### Ethical Data Handling

Both datasets are public, fully aggregated to the continental level, and contain no personally identifiable or sensitive information. We comply with the UNdata Terms of Use by attributing the United Nations Statistics Division as the source in this README, the data dictionary, the metadata file, and the analysis notebook. No data is redistributed in modified form without attribution. Because we work exclusively with continental aggregates rather than country-level data, no country-specific privacy or political sensitivity concerns apply. All original work created by the team (code, report, data dictionary, metadata, derived analysis outputs) is released under the Creative Commons Attribution 4.0 International License (CC BY 4.0); see `LICENSE`. The two source CSVs remain subject to the UNdata Terms of Use, separate from this project's CC BY 4.0 license.

---

## Data Quality

The `value` column in both raw CSV files is stored as a string rather than a numeric type, and contains thousands-separator commas (for example, `"1,234,567"`). This prevents direct numeric parsing. This formatting issue affects the majority of rows with large values across both datasets. We addressed it by stripping commas before applying `pd.to_numeric(..., errors='coerce')`, which also handled a small number of cells containing footnote markers such as `"..."` or blank entries by converting them to `NaN`. In practice, the merged dataset ended up with zero NaN values across all columns, since the UN's continental aggregates are fully populated for the years and indicators we use.

A second issue in the energy dataset is that country-level rows and regional aggregate rows appear together in the same file, with no separate flag column to distinguish them. The UN assigns specific numeric codes to its six continental aggregates: 2 for Africa, 9 for Oceania, 21 for North America, 142 for Asia, 150 for Europe, and 419 for Latin America & the Caribbean, codes which must be identified manually using UN documentation. Without this step, a naive row-level analysis would combine individual country values with the regional totals that already include them, causing double-counting and inaccurate results. Temporal coverage for some smaller countries and territories is also incomplete within the energy dataset. This did not affect our analysis, however, since the six continental aggregates we focused on had complete series for all available years.

The two datasets do not share identical year sets: the GDP dataset includes 2023 (not present in energy), while the energy dataset includes 2000 and 2021 (not present in GDP). The intersection consists of six common years: 1995, 2005, 2010, 2015, 2020, and 2022. An inner join on `(continent, year)` naturally retains only these six years, which is the basis for the 36-row merged dataset. As an additional safeguard, the notebook also explicitly drops `year == 2023` after the merge to make the year-filtering intent unambiguous in the code; in practice this filter has no effect on the merged data because 2023 is already excluded by the inner join. The GDP growth rate variable contains a small number of `NaN` values in early years for certain regions, though this does not affect our analysis since the growth rate is not used as a predictor or outcome in the regression model.

After integration, the merged continent-year dataset contains 36 rows. Missing-value counts across all columns in the merged dataset are effectively zero for continental totals, confirming that the UN compiles these summaries thoroughly. For the purposes of cross-regional comparison at the aggregate level, the dataset is high quality.

One structural constraint is worth highlighting. The population-weighted averages of continental GDP per capita are calculated across nations with very different economic profiles. For example, Africa contains some of the world's lowest-income nations as well as high-income oil-exporting nations; the regional average completely flattens this difference. The same applies to Asia, which contains economies ranging from some of the world's richest to some of the least developed. This is a natural consequence of using continental-level aggregates rather than country-level data. Although the overall numbers are internally consistent and suitable for cross-regional analyses, they cannot be used to make claims about conditions inside specific nations. This limitation is discussed further in the Challenges section.

---

## Data Cleaning

The data cleaning workflow consisted of several operations designed to transform two raw CSV datasets into a consistent, analysis-ready format suitable for statistical analysis and modeling.

First, comma-based thousands separators present in the `value` column (e.g., `"45,231,900"`) were removed using a string replacement operation (`.str.replace(",", "", regex=False)`), as these entries were initially parsed as strings and could not be directly converted into numeric datatypes. This step affected many rows across both datasets and was a prerequisite for any subsequent numerical and graphical analysis.

Then, residual non-numeric entries, like blank fields, ellipses (`"..."`), or footnote markers, were handled by applying `pd.to_numeric(..., errors='coerce')`, which converted such anomalies into `NaN` values. This ensured that invalid data points did not break computations while keeping all valid numerical observations. In practice, no cells required coercion in the continental aggregate rows we used; `errors='coerce'` is retained as a safeguard against potential future edge cases.

The next step involved filtering the datasets to only the continental aggregate observations. Because the raw data contained both country-level and regional aggregates with no explicit indicator column, six UN-defined aggregate codes (2, 9, 21, 142, 150, 419) were identified from the UN documentation and used to filter the data via `df[df["country_code"].isin(CODE_TO_NAME)]`. This filtering step was critical to avoid double-counting and to ensure we were comparing only continents rather than individual countries. To increase interpretability, we added a new column containing continent names by mapping each retained country code to its corresponding label using a predefined dictionary. This `continent` variable subsequently served as the primary grouping dimension for analysis and visualizations.

Both datasets were originally structured in long format, with each row representing a single country-year-series combination. To facilitate multivariate analysis, each dataset was reshaped into wide format using `df.pivot_table(index=["continent", "year"], columns="series", values="value")`. This produced a structure with one row per continent-year and separate columns for each indicator. This transformation is essential for regression and correlation techniques, which require variables to be organized column-wise.

The temporal alignment was handled by performing an inner join on `(continent, year)`, which automatically restricts the merged dataset to years present in both sources (1995, 2005, 2010, 2015, 2020, 2022). As a defensive measure, the notebook also explicitly drops `year == 2023` after the merge; this is redundant with the inner join but documents the intent explicitly in the code.

Finally, we derived a new variable, **energy intensity**, computed as:

```
merged["energy_supply_pj"] / merged["gdp_current_musd"] * 1_000
```

This yielded a measure of energy consumption per unit of economic output (petajoules per billion USD). This metric provides an indicator of how efficiently each continent converts energy into economic activity, offering a more analytically meaningful basis for comparison than raw energy supply or GDP values alone.

Collectively, these cleaning steps ensured data integrity, comparability, and suitability for statistical analysis.

---

## Findings

The OLS regression model predicting GDP per capita from energy per capita, total energy supply, and primary energy production achieved an R² of 0.852 (Adj. R² = 0.839), indicating that these three energy variables jointly explain roughly 85% of the variance in continental GDP per capita across all region-year observations. The F-statistic was highly significant (F = 61.58, p < 0.001), confirming that the model explains significantly more variance than a null intercept-only model.

Among individual predictors, energy supply per capita (measured in gigajoules per person) showed the strongest and most statistically significant positive coefficient (β = 214.87, t = 13.36, p < 0.001), consistent with its Pearson correlation of r ≈ +0.87 with GDP per capita. This suggests that how much energy is available per person in a region is more predictive of per-capita wealth than the region's total absolute energy production. Total energy supply and primary energy production each showed statistically significant but opposing effects once energy per capita was controlled for (β = −0.69 and +0.74 respectively), likely reflecting multicollinearity among these volume-based measures, a concern flagged directly by the model's large condition number (4.65 × 10⁵).

From the correlation matrix, GDP per capita showed the following correlations with energy variables: energy per capita (r ≈ +0.87), energy intensity (r ≈ −0.64), energy supply (r ≈ −0.08), and energy production (r ≈ −0.10). Notably, both volume-based energy measures show near-zero or slightly negative correlations with GDP per capita, in contrast to their strong positive correlations with total GDP. The negative correlation with energy intensity indicates that wealthier regions tend to be more energy-efficient: they generate more economic output per unit of energy consumed, which is consistent with the observation that high-income economies are typically more service-oriented and technologically advanced.

The time-series visualization reveals that North America has maintained the highest GDP per capita throughout the study period, while Africa remains the lowest. North America and Oceania both exhibit a notable acceleration after 2020, reaching approximately $74,063 and $46,563 respectively by 2022. Asia's GDP per capita has grown in relative terms, rising from approximately $2,680 to $8,022, but its line remains comparatively flat, staying close to the lower end of the distribution throughout the period. The negative correlation between energy intensity and year (r ≈ −0.56) suggests that energy intensity has declined over time across most regions, which may reflect improvements in energy efficiency, structural economic shifts toward services, or both.

The scatter plot of total energy supply (PJ) versus total GDP (current USD, millions) shows a broadly positive relationship across continent-year observations. The highest-energy, highest-GDP points correspond to Asia and North America in recent years, while the dense cluster in the lower-left reflects Africa, Latin America, and Oceania observations across multiple time periods.

---

## Future Work

There are several ways this project could be extended. The most useful would be **moving from continental aggregates to country-level data**. Working at the continent level is simpler but hides a lot of variation between countries within the same continent. A country-level analysis using fixed effects for country and year, which is a common approach in development economics, would give a clearer picture of the energy-GDP relationship by controlling for country-specific factors and global time trends at the same time.

A second direction would be to **look at causation rather than just correlation**. Our model had an R² of 0.852, but a high R² only shows that the variables move together, not that one causes the other. Energy production could drive GDP growth, or higher GDP could fund more energy infrastructure, or both could be shaped by other factors like institutions or geography. Future work could explore methods that better separate cause from effect, such as comparing how changes in energy use over time line up with later changes in GDP, to get a clearer sense of which direction the relationship runs.

Third, **adding more variables would make the analysis richer**. The original project plan included employment and agricultural productivity, but we did not end up using them due to data and time constraints. Bringing in labor-force participation, sectoral GDP breakdowns (manufacturing, services, agriculture), or share of renewable energy would help explain what shapes the energy-GDP relationship.

Fourth, **the time range and granularity could be expanded**. Although we used six common time points between 1995 and 2022, the underlying UN datasets are themselves only at 5-year intervals (with a few additional recent years), limiting our temporal resolution. Other public data sources like the World Bank provide annual data extending further back in time, which would let us look at how things changed around major events like the 1970s oil shocks, the fall of the Soviet Union, or the COVID-19 pandemic.

A fifth direction is **improving the regression itself**. Total energy supply and primary energy production are correlated at r ≈ 0.99 in our data, meaning they carry almost identical information; including both in the regression makes the individual coefficient estimates unreliable. Future work could try removing one of the redundant predictors, or use other regression methods designed to handle correlated variables (e.g., ridge regression or principal-components regression). The relationship between energy and GDP may also not be linear; using log transformations or polynomial terms might fit the data better than a straight line.

Finally, this analysis treats all energy types the same, combining fossil fuels, nuclear, and renewables into one total supply number. **Breaking energy down by type** and seeing if regions with more renewables show a different GDP-energy relationship would be a timely extension given the ongoing energy transition.

**Lessons learned.** Working with UN data taught us that "clean" public datasets still require substantial preparation: format issues like comma separators, mixed country/aggregate rows, and small temporal mismatches across related datasets are common, and addressing them carefully is what makes an analysis trustworthy. We also learned that a high R² is not enough to claim explanatory power. Multicollinearity diagnostics and an honest discussion of sample size are equally important.

---

## Challenges

**Identifying continental aggregate rows.** The most technically subtle challenge was distinguishing continental aggregate rows from individual country rows within the raw datasets. The UN embeds both in the same CSV file using only numeric codes as the distinguishing feature, with no explicit flag column. We had to consult UN documentation to identify the specific numeric codes assigned to each continental region. A naive analysis that summed all rows would have double-counted country values already included in the continental totals.

**Value column parsing.** The `value` column in both CSVs is stored as a string with comma thousands separators, which is not a standard CSV convention but a formatting choice from the UN's data export system. This required a pre-processing step before any numeric operations. Additionally, some cells contained footnote markers or empty strings rather than numeric values; these had to be handled gracefully to avoid parse errors.

**Temporal alignment.** The two datasets cover overlapping but non-identical year sets. GDP includes 2023 but skips 2000 and 2021; energy includes 2000 and 2021 but skips 2023. Resolving this required relying on an inner join to retain only the six common years (1995, 2005, 2010, 2015, 2020, 2022). Without explicit attention to this asymmetry, a careless merge could have introduced `NaN`-filled rows that silently distort summary statistics or regression estimates.

**Continental-level aggregation limitations.** Working at the continental level solves the missing-data problem for individual countries but introduces an ecological-inference problem: results at the continental level may not apply at the country level. For example, the strong positive correlation between energy per capita and GDP per capita across continents reflects in part the contrast between highly developed and developing regions; within a single continent, the relationship might look quite different.

**Collinearity among energy predictors.** Total energy supply and primary energy production are correlated at r ≈ 0.99 in our data, since most of the energy a region produces also gets consumed there. Including both in a single regression creates multicollinearity, which inflates standard errors and makes the individual coefficients hard to interpret. We kept all three predictors for completeness but acknowledge this limitation.

**Small sample size.** After merging and filtering to continental aggregates, our dataset contains only 36 observations (6 continents × 6 time points). With three predictors, this is on the lower end of what is reliable for OLS regression. Patterns we identified should be interpreted as exploratory rather than definitive.

**Coordinating asynchronous teamwork.** Both team members typically drafted content locally before pushing to GitHub, which means the commit history does not always reflect the iterative back-and-forth of the work. We addressed this by including the contribution statement above and by reviewing each other's work before finalizing each section.

---

## Reproducing

To reproduce the full analysis from a clean environment:

### 1. Clone the repository

​```git clone https://github.com/PragunJ/IS-477_analysts.git```

```cd IS-477_analysts​```

### 2. Set up the Python environment

The analysis was developed and tested on **Python 3.11** (Google Colab, May 2026). Install dependencies:

​```pip install -r requirements.txt```

The exact package versions used during our final analysis run were:

- pandas 2.2.2
- numpy 2.0.2
- matplotlib 3.10.0
- seaborn 0.13.2
- statsmodels 0.14.6

The file `pip_freeze.tx` in the repository contains the precise pinned versions (with `==`) of the analysis-relevant packages from the environment in which the final results were generated, for full reproducibility.


### 3. Verify data integrity

The raw CSVs are stored with the repository under `Datasets/`. The `Final_Script.ipynb` notebook computes and prints SHA-256 checksums for both files when executed. You can also verify them manually against the recorded hashes in `checksums.txt`:

Expected hashes:

​```8091d7ba3b94ad60477a66cd41fd7b0a1dd1cafd5014ccda74f6c6032e9da9ac  GDP and GDP Per Capita 2025.csv```
```425460565f23d953116e9233a3548d6e51ee2d4b14bc3348e6886aee3119ece2  Energy Production and Supply Data.csv​```

### 4. Run the full analysis

**Option A (recommended):** Use the provided run-all script, which verifies SHA-256 checksums and executes the notebook end-to-end:

```bash run_all.sh```

**Option B:** Open `Final_Script.ipynb` in Jupyter or Google Colab and use **Run All** from the menu.

Either option will:

1. Download (or use cached) UN CSVs from `Datasets/`
2. Compute and print SHA-256 checksums for integrity verification
3. Clean and integrate the data
4. Generate the correlation heatmap, time-series plot, scatter plot, and OLS regression summary

### 5. Note on `Current_Progress.ipynb`

The file `Current_Progress.ipynb` is preserved as the version submitted for the Milestone 3 (Interim Status Report) release and is not part of the final reproducible workflow. Use `Final_Script.ipynb` for reproduction.

### 6. Outputs

All analytical outputs (regression summary, correlation heatmap, time-series line plot, energy-vs-GDP scatter plot) are produced inline in the executed notebook.

---

## References

### Datasets

- United Nations Statistics Division. (2025). *GDP and GDP Per Capita* [Data set, series SYB68_230_202511]. UNdata. Retrieved from https://data.un.org/_Docs/SYB/CSV/SYB68_230_202511_GDP%20and%20GDP%20Per%20Capita.csv
- United Nations Statistics Division. (2025). *Production, Trade and Supply of Energy* [Data set, series SYB68_263_202511]. UNdata. Retrieved from https://data.un.org/_Docs/SYB/CSV/SYB68_263_202511_Production,%20Trade%20and%20Supply%20of%20Energy.csv

### Software

The analysis was conducted in Python 3.11 using pandas, numpy, matplotlib, seaborn, and statsmodels. Specific package versions are recorded in `requirements.txt` and `pip_freeze.txt`.

### Terms of Use

- United Nations Statistics Division. *UNdata Terms of Use*. https://data.un.org/Host.aspx?Content=UNdataUse
