# Data Dictionary

This file documents every variable used in the project, including the raw
columns from the two source CSVs and the derived columns in the final merged
dataset.

---

## Raw Dataset 1: `Datasets/GDP and GDP Per Capita 2025.csv`

**Source:** UNdata
(SYB68_230_202511_GDP and GDP Per Capita)

| Column | Type | Unit / Domain | Description |
|---|---|---|---|
| `country_code` | integer | UN M49 numeric code | Country or regional aggregate identifier. Continental aggregates use codes 2 (Africa), 9 (Oceania), 21 (North America), 142 (Asia), 150 (Europe), 419 (Latin America & Caribbean). |
| `country_name` | string | — | Human-readable name of the country or aggregate region. |
| `year` | integer | calendar year | Reference year. Available years for continental aggregates: 1995, 2005, 2010, 2015, 2020, 2022, 2023. |
| `series` | string | indicator label | Name of the GDP indicator (see series list below). |
| `value` | string → float | varies by series | Measured value. Stored as a string in the raw CSV with comma thousands separators (e.g., `"1,234,567"`); converted to float during cleaning. |
| `footnotes` | string | — | UN footnote markers (e.g., estimation notes). Mostly empty for continental aggregates. |
| `source` | string | — | UN source reference for the underlying data. |

**`series` values present in this dataset:**

| Series | Unit | Description |
|---|---|---|
| GDP in current prices | millions of US dollars | Total GDP measured at the prices of the reference year. |
| GDP in constant 2015 prices | millions of US dollars (2015 base) | Total GDP deflated to 2015 prices, removing inflation effects. |
| GDP per capita | US dollars per person | GDP in current prices divided by mid-year population. |
| GDP real rates of growth | percent | Annual growth rate in real (inflation-adjusted) GDP. |

---

## Raw Dataset 2: `Datasets/Energy Production and Supply Data.csv`

**Source:** UNdata
(SYB68_263_202511_Production, Trade and Supply of Energy)

The column schema is identical to Dataset 1. Available years for continental
aggregates: 1995, 2000, 2005, 2010, 2015, 2020, 2021, 2022.

**`series` values present in this dataset:**

| Series | Unit | Description |
|---|---|---|
| Primary energy production | petajoules (PJ) | Total energy produced from primary sources (coal, oil, gas, nuclear, hydro, renewables). |
| Net imports [Imports − Exports − Bunkers] | petajoules (PJ) | Net energy crossing the region's borders, excluding international bunker fuels. |
| Changes in stocks | petajoules (PJ) | Net change in energy held in reserves over the year. |
| Total supply | petajoules (PJ) | Total energy available in the region: production + net imports ± stock changes. |
| Supply per capita | gigajoules (GJ) per person | Total supply divided by population, converted to gigajoules. |

---

## Merged Analysis Dataset (`merged`)

After cleaning, filtering to the six continental aggregates, pivoting from long
to wide format, and inner-joining on `(continent, year)`, the analysis dataset
has **36 rows × 11 columns** (6 continents × 6 common years: 1995, 2005, 2010,
2015, 2020, 2022).

### Identifier columns

| Column | Type | Description |
|---|---|---|
| `continent` | string | One of: Africa, Asia, Europe, Latin America & Caribbean, North America, Oceania. Derived by mapping `country_code` through the dictionary `{2: "Africa", 9: "Oceania", 21: "North America", 142: "Asia", 150: "Europe", 419: "Latin America & Caribbean"}`. |
| `year` | integer | One of: 1995, 2005, 2010, 2015, 2020, 2022. |

### GDP variables (renamed from raw series)

| Column | Unit | Source series |
|---|---|---|
| `gdp_current_musd` | millions of US dollars | GDP in current prices (millions of US dollars) |
| `gdp_constant_musd` | millions of US dollars (2015 base) | GDP in constant 2015 prices (millions of US dollars) |
| `gdp_per_capita_usd` | US dollars per person | GDP per capita (US dollars) |
| `gdp_growth_pct` | percent | GDP real rates of growth (percent) |

### Energy variables (renamed from raw series)

| Column | Unit | Source series |
|---|---|---|
| `energy_production_pj` | petajoules | Primary energy production (petajoules) |
| `energy_supply_pj` | petajoules | Total supply (petajoules) |
| `energy_per_capita_gj` | gigajoules per person | Supply per capita (gigajoules) |
| `net_imports_pj` | petajoules | Net imports [Imports − Exports − Bunkers] (petajoules) |
| `stock_changes_pj` | petajoules | Changes in stocks (petajoules) |

### Derived variable

| Column | Unit | Formula | Description |
|---|---|---|---|
| `energy_intensity` | petajoules per billion USD | `(energy_supply_pj / gdp_current_musd) × 1000` | Energy consumed per unit of economic output. Lower values indicate greater energy efficiency. |

---

## Continental Aggregate Codes (Reference)

The UN embeds country-level rows and regional aggregate rows in the same CSV.
These six numeric codes identify the continental aggregates used in this
project:

| UN code | Continent |
|---|---|
| 2 | Africa |
| 9 | Oceania |
| 21 | North America |
| 142 | Asia |
| 150 | Europe |
| 419 | Latin America & Caribbean |

These codes follow the [UN M49 standard](https://unstats.un.org/unsd/methodology/m49/)
for area classification.

---

## Data Quality Notes

- The `value` column in both raw CSVs uses comma thousands separators and is
  stored as a string. It must be cleaned with
  `.str.replace(",", "", regex=False)` before numeric parsing.
- A small number of cells contain footnote markers (`"..."`) or blanks; these
  become `NaN` after `pd.to_numeric(..., errors="coerce")`.
- For continental aggregates only, missing values in the merged dataset are
  effectively zero across the variables used in analysis.
- The two source datasets share six common years after inner-joining;
  GDP-only years (2023) and energy-only years (2000, 2021) are dropped.
