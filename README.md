# Data_pipeline_Project
#### Author: Vincent Wai Seng Lee

__Life Expectancy and Socioeconomic status in American states__

__Executive summary:__
1. Life expectancy in the United States has plateaued over the last decade (2008-2017), which has drawn concern towards the growing disparities at the state, income, and demographic level.
2. Studies have also shown that life expectancy increases with the socioeconomic status; however, many of the estimates are mainly based on 2 to 3 factors only (e.g. income and state)
3. A more comprehensive approach is required to identify the magnitude of the disparities and its factors affecting life expectancy

__Problem statement:__ 
1. Objective: To provide a holistic estimate of life expectancy and identify reasons for the life expectancy disparities so that government agencies can design better policies for higher risk areas.
2. Problem statement: How does life expectancy get impacted by socioeconomic factors  (income, mortality risk, healthcare expenditure per capita)? 
3. Do demographics (e.g. gender, race, and age) at the state level contribute largely to the life expectancy disparities?

__Datasets and source__
1. Life expectancy and mortality risk by gender and state (Institute for Health Metric and Evaluation)
2. Life expectancy by race and state (Center for Disease Control and Prevention)
3. Income data by quartile (Internal Revenue Service)
4. Life expectancy by income quartile by state (Journal of the American Medical Association)
5. Resident population by state (US Census Bureau)
6. Healthcare expenditure by state (Kaiser Family Foundation)
7. Health insurance coverage by state (US Census Bureau)
8. Number of hospitals by state (American Hospital Association)

__Data pipeline__
1. Data extraction and preparation
    a. Datasets extract using csv download, 
    b. Data cleaning and transforming using Python and Excel Pivot (file: Data_cleaning_lifeexpectancy.ipynb)
2. Data warehouse (SQL OLAP) and data lake (Cloud SQL) 
    a. Star schema and store data at Cloud SQL (file: SQL Workbench Scripts)
3. Insights (Python and Tableau)
    a. Modeling (Linear regression model) (file: Model_to_estimate_person_lifeexpectancy_US.ipynb)
    b. Visualization (Tableau)
    
__Exploration of NoSQL__
1. Use case for MongoDB (document database) -connecting life expectancy data with health or tax record documents 
    a. For details, kindly refer to MongoDB folder - file: Exporting_lifeexp_factable_to_MongoDB.pdf
2. Use case for Neo4J (graph database) - identifying relationships of persons with outlier life expectancy 
    a. For details, kindly refer to Neo4J folder - file: Scripts_lifeexpinNeo4J.txt

__Insights__
1. Results of linear regression model show that gender, income and mortality risk  are the most sensitive features for life expectancy
2. Mississippi has the lowest life expectancy and uninsured rate is one of the main contributing factors to the gap in states
3. High income group has higher life expectancy yet over 60% earned below $50k annually (below median US household income of $68k2)
4. Females have higher life expectancy than males as males has higher mortality risk than females.
5. Hispanics have higher life expectancy than white and black populations due to better health habits and stronger networks of social support in the Hispanic community 

__Recommendations for data pipeline design__
1. Reasons of choosing Google Cloud SQL as data lake: 
a. More suitable for relational type of data
b. Storage cost is relatively inexpensive, automated backups, updates can be made quickly
c. Data can be shared easily across multiple users

2. Reasons of choosing Tableau for data visualization: 
a. Provides live data connection with Google Cloud SQL
b. User-friendly and many features are available 

__Recommendations for corrective measures__
Proposed strategies to life expectancy gaps among Americans: 
a. Affordable healthcare services for the lower income groups (income bracket below $25,000)
b. Provide economic investment to the southeastern states to spur job growth
c. Target healthy-lifestyle campaigns towards higher risk populations.

__References__
References for entire data pipeline

1.Life expectancy and mortality risk by gender and state 
http://ghdx.healthdata.org/record/ihme-data/united-states-life-expectancy-and-age-specific-mortality-risk-county-1980-2014

2. Life expectancy by race and state 
https://www.cdc.gov/nchs/data/hus/2018/004.pdf

3. Income data by income quartile https://www.irs.gov/statistics/soi-tax-stats-individual-statistical-tables-by-tax-rate-and-income-percentile

4. Life expectancy by income by state 
https://healthinequality.org/

5. Resident population by state 
https://www.census.gov/newsroom/press-kits/2018/pop-estimates-national-state.html

6. Health care expenditure per capita by state 
https://www.kff.org/other/state-indicator/health-spending-per-capita

7. Health insurance coverage by state 
https://www.census.gov/data/tables/time-series/demo/health-insurance/historical-series/hic.html

8. Number of hospitals by state 
https://www.aha.org/statistics/fast-facts-us-hospitals

9. Feature selection 
https://towardsdatascience.com/feature-selection-with-pandas-e3690ad8504b

10. Multilinear regression model for life expectancy 
https://www.seas.upenn.edu/~ese302/Projects/Project_2.pdf

11. Government use-cases for MongoDB 
https://www.mongodb.com/industries/government

12. Population Reference Bureau: “Exploring the Paradox of U.S. Hispanics’ Longer Life Expectancy” 
https://www.prb.org/us-hispanics-life-expectancy/

13. Median US household income 
https://www.census.gov/content/dam/Census/library/publications/2015/demo/p60-252.pdf






