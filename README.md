# Data Projects

## Citi Bike Analysis

The purpose of this project is to extract, load, and analyze the Citi Bike ridership data. Light cleaning was required on the data set, mostly formatting the column labels and removing NA's as well as outliers. Outliers in this data set could be broken down into two categories birth year and trip duration. Birth year is a user specified variable with many users selecting 1969. While trip duration over 3 hours was assumed to be a result of improper docking, due to the associated cost of extended trips.

The data was then uploaded into a Postgres database using psycopg2. The data then analyzed for trends in rider count and trip duration broken down over time, user type, and gender. Significant trends were observed with subscribers being the main users during weekday rush hour, and customers (single pass users) being the main users during weekends.


## Public Tableau

Link to my public [Tableau Account](https://public.tableau.com/app/profile/austin.marvin6543).
