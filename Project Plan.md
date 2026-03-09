**Overview**: Describe the overall goal of your project and your planned approach to achieve it. Explain what you aim to accomplish and outline the main steps or methods you will use to execute the project (max 250 words).

The goal of this project is to investigate the relationships between **economic development, energy production, employment, and agricultural productivity across countries over time**. Economic growth is influenced by many interconnected factors, including the availability of energy resources, the size and productivity of the labor force, and the efficiency of agricultural production systems. By combining multiple international datasets, this project seeks to better understand how these factors interact and whether patterns emerge across different countries and regions.  
To accomplish this objective, we will integrate several datasets obtained from the **United Nations Data Portal (UNdata)**, including datasets on **Agricultural Production Index values, employment statistics, energy production and supply, GDP, and GDP per capita**. These datasets share common attributes such as **country identifiers and year**, which makes it possible to merge them into a single dataset for analysis.  
After collecting the data, we will clean and standardize the datasets to ensure that **country names, country codes, time periods, and measurement units** are **consistent** across sources. Once the datasets are merged, we will conduct exploratory data analysis to identify **trends, patterns, and possible relationships between energy production, employment levels, agricultural productivity, and economic output**.  
Finally, we will apply quantitative analysis techniques such as correlation analysis and regression models to evaluate the strength of these relationships. We will also create visualizations including time-series graphs, scatter plots, and comparative charts to clearly illustrate patterns and changes across countries and over time.

**Word count: 235**

**Team**: Clearly define team member roles and responsibilities.

**Member 1 – Data Engineer**

Responsibilities include:

* Coordinating project planning and timeline management  
* Collecting datasets from the UN data portal  
* Cleaning and standardizing data (country names, year formats, and units)  
* Merging datasets using shared identifiers such as country and year  
* Assisting with the interpretation of analytical results

**Member 2 – Data Analyst & Visualization**

Responsibilities include:

* Conducting exploratory data analysis  
* Performing statistical analysis such as correlation and regression  
* Creating visualizations to illustrate patterns and relationships in the data  
* Interpreting findings and summarizing key insights  
* Preparing figures and slides for the final presentation

Both team members will collaborate on the **final report writing, interpretation of results, and project presentation**.

* **Research or Business Question(s)**: What is/are the question(s) you intend to address? These could be research questions, business questions, or analytical questions you want to answer through data analysis.

Our project aims to address the following questions:

* How does energy production relate to GDP per capita across countries?  
* Is there a relationship between employment levels and national economic productivity?  
* Do countries with stronger energy supply systems tend to show higher agricultural output and employment rates?  
* How have these relationships evolved over time across different regions?


  * **Datasets**: Identify and describe the datasets you will use to answer your question(s). You need to use **at least two different datasets** that complement each other and **can be** **integrated together**. The datasets should each contribute different but related information needed to **address your questions**, and they must share common attributes or identifiers that allow you to link them. For example, if one dataset contains demographic information and another contains economic indicators, they should both include geographic codes or time periods that enable meaningful integration.If you need help finding suitable datasets, start by reviewing the [list of datasets provided in class](https://docs.google.com/document/d/171zIAytwR9oD9tVIzJdqgqnHotFcEDLx56KkbSSIOR4/edit?tab=t.0#heading=h.lzvxkydu0ozk). 

We will use datasets obtained from the **United Nations Data Portal (UNdata)**.

### **1\. Agricultural Index Dataset**

This dataset contains agricultural production index values by country and year. The index measures changes in agricultural output relative to a base period.

**Key variables**

* Country  
* Year  
* Agricultural production index

### **2\. Employment Dataset**

This dataset provides employment statistics across countries and time.

**Key variables**

* Country  
* Year  
* Employment rate or employment counts

### **3\. Energy Production and Supply Dataset**

This dataset includes information about national energy production and supply levels.

**Key variables**

* Country  
* Year  
* Energy production  
* Energy supply

### **4\. GDP and GDP Per Capita Dataset**

This dataset includes economic indicators used to measure national development.

**Key variables**

* Country  
* Year  
* GDP  
* GDP per capita

### **Data Integration**

All datasets include **country identifiers and time periods**, allowing them to be merged using **Country \+ Year**. Combining these datasets will allow us to analyze how **economic output, energy production, employment, and agriculture interact across countries and over time**.

* **Timeline**: Provide a draft of the plan and timeline for completing your project. Include a list of specific tasks you need to accomplish, a brief description of each task, when each task will be completed, and who will be responsible for completing it.


| Week | Task | Description | Responsible |
| :---: | :---: | :---: | :---: |
| Week 7 | Dataset Collection | Download datasets from UNdata and review variable structures | Data Engineer |
| Week 9 | Data Cleaning | Handle missing values, standardize country names/codes, format variables | Data Engineer |
| Week 10 | Data Integration | Merge datasets using country and year identifiers | Data Engineer  |
| Week 11 | Statistical Analysis | Conduct correlation and regression analysis | Data Analyst |
| Week 12 | Visualization Development | Create charts and graphs to illustrate findings | Data Analyst & Visualization  |
| Week 13 | Interpretation | Analyze results and draft conclusions | Whole Team |
| Week 14 | Final Report & Presentation | Compile report and prepare presentation | Whole Team |


  * **Constraints:** Describe any known limitations or challenges with your datasets or approach. These might include legal or ethical restrictions, unknown data provenance, technical difficulties in processing the data, issues with data completeness, limited temporal or spatial coverage, accessibility barriers, or other relevant concerns that could affect your work.

Several limitations may affect the analysis:

* **Missing Data:** Some countries may have incomplete records for certain years.  
* **Different Reporting Standards:** Data may be collected differently across countries, potentially affecting comparability.  
* **Temporal Coverage:** Some datasets may cover different time ranges.  
* **Aggregation Issues:** National-level data may hide regional variation within countries.


  * **Gaps:** Identify any known gaps or areas where you need additional input.

Some aspects of the project may require further clarification or improvement:

* Determining the best statistical models to quantify relationships between variables  
* Deciding whether to analyze all countries or focus on specific regions  
* Determining the time period to use if the dataset coverage differs  
* Identifying additional derived variables (e.g., energy per capita or agricultural output per worker)


  * *Your plan should anticipate later course topics even if you don’t yet know all the details. It is expected that your plan will evolve over time.*

