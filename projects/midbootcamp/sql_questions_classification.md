
# PostGreSQL Questions - Classification - Caitlin Data 

(Use sub queries or views wherever necessary)

1. Create a basic ERD of the main tables/tables you will be using from your database - including lookup tables which you would access using the foreign key and a JOIN
2. Create SQL queries selecting the columns you want to work with in items , customers, buys tables 
3.  Select all the data from table `buys` for those columns 
5.  Use the _alter table_ command to add a new column to any of your tables. You can hardcode a fixed (dummy) variable or drop and re add a field (optional)
6.  Use sql query to find how many rows of data you have in one of your tables
7.  Now we will try to find the unique values in some of the categorical columns:

    - how many unique values in the column 'postal code'?
    - What are the unique values in the column `gender`?
    - how many unique values in the column `id` in buys table?
    - What are the unique values in the column `points_return`?
    - What are the unique values in the column `material_id`?
    
8.  Arrange the data in buys table by decreasing order of the `retail price` of the buys. Return only the `customer_id` of the top 50 customers with the highest `retail price` in your data.
9.  What is the average retail price of all the customers in your buys table?
10. In this exercise we will use a simple group by query to check the properties of some of the categorical variables in your item table. Note wherever `offer value` is asked, please take the average of the column `offer value': 

    - What is the average offer value of the buys? The returned result should have only two columns, offer value and buy id
    - What is the average offer value of each brand? The returned result should have only two columns, offer value and brand, with as many rows as brands
    - What is the average offer value by customerid? The returned result should have only two columns, customerid (not name) and offer value
    - what is the average offer value by month? the returned result will have as many rows as you have months and years in your dataset.
    - Is there any obvious correlation re offer value between the columns `material_id` and `pattern_id`? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

11. Your analysis is only focused on the customers with the following properties:

    - have accepted only cash in the past
    - have been a customer on more than one occasion

    For the rest of the customer profiles, you are not too concerned. Write a simple query that captures such data with columns which may be interesting, in your perspective, to understand the behaviour of such customers. 

12. You want to find a list of customers whose average points sum is higher than the average points sum of all the customers in the database. Write a query to show the list of such customers. You might need to use a subquery for this problem.
13. Since this is something that you are regularly interested in, create a view of the same query.
14. What is the number of customers or buys who accepted the points vs number of people who did not?
15. Provide the postcode and gender (not name) details of a customer that is the 15th highest `points_sum` in your database.
16. Provide the postcode and gender (not name) details of a customer that is the 15th highest `retail_price` in your database.
 
 


# SQL Questions - Classification - Julien Data 

(Use sub queries or views wherever necessary)

1. Create an ERD and accompanying database called `democracy studio'.   
2. Create the tables to hold your data including defining primary and foreign keys 
3. Import the data from your data sources into the tables
4.  Select all the data from table `agent` to check if the data was imported correctly.
5.  Use the _alter table_ command to add a new column to any of your tables. You can hardcode a fixed (dummy) variable or drop and re add a field (optional)
6.  Use a sql query to find how many rows of data you have in one of your tables
7.  Now we will try to find the unique values in some of the categorical columns:

    - What are the unique values in the column `city`? ie city name/ city id
    - What are the unique values in the column `collection channel`?
    - How many unique values inside the classifications of Agent Type and Agent Category? 
    - What are the unique values in the column `twitter profile?
    - What are the unique values in the column `engagement_type`?

8.  In this exercise we will use (joins and) group by to check the variance in our data

    - how many agents per each city in your data?
    - How many twitter data points (hint : count unique timestamps + profiles, or tweet id) do you have per each city/gender/month ? (Sian's note: I am not sure in which ways you can aggregate this data so I will leave this to you to choose!)
    - how many agents per each agent category?
    - how many agents are influenced by individuals, government or research? 

11. lets pretend you are only interested in the agents with the following properties:
    - very high engagement with smart cities 
    - active on social media
 how would you define this profile? 
 can you visualise the process you go through to categorise such individuals? 
 can you implement sentiment analysis techniques or another logical flow to categorise all of your existing agents in such a way? 
 is there a way to integrate this boolean field T/F on high engagement with our SQL database or does it logically live elsewhere?

12. You want to dig into the survey data collected on one city - Tel aviv - and compare the responses of this city to the rest, to see if there are any visible differences in either the number of agents, the variation in their answers or the positive /negative responses to one question.  Write a query to show the list of such agents and the comparative survey data you have. You can select just one or two questions if easier. Hint : you might need to use a subquery for this comparison problem.
13. Since this is something that you want to revisit regularly interested in, create a view of the same query.
14. Provide the details of the tweeter with the fifth highest number of collected responses (assuming you have more than one post from some individuals)
