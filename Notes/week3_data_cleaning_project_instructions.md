# General project description

Here's your challenge for your next group project! the **deadline** for finishing is **next Monday**; I will give you class time through the rest of the week/Monday and we will share your work with the whole class next week.

You will be working with a data set hosted on Kaggle that has been scraped for you from the web about US data science hires in 2018 (ie pre-covid!). The author wanted to look at some specific questions :

* Who gets hired? What kind of talent do employers want when they are hiring a data scientist?
* Which location has the most opportunities?
* What skills, tools, degrees or majors do employers want the most for data scientists?

I think you can do more with this data set but as it's from the web it's not easy to work with at the moment. Your main challenge is to use SQL and/or Python to clean, wrangle and generally reshape the data to make it straightforward for you to analyse from.  

I would like you to form a group (2-5 students) to work with; as we are all remote now we can learn from each-other while applying your recently acquired skills to work with messy data and discover then focus on some insights from the data.

The insights you find can be documented simply with screenshots of your SQL query results/previews in your SQL client (or if you feel confident using them, from data frames and matplotlib /seaborn (saved out as images) from your python jupyter notebook), accompanied by some simple annotation/text summarising what you found/how easy it was to get there. What we want from each group is a one pager, infographic, blog page or slide describing what you learnt from the data and what the gaps in the data or limitations of it were. For inspiration on what sort of insights you might look into, you can see the web scraper's blog [here](https://nycdatascience.com/blog/student-works/who-gets-hired-an-outlook-of-the-u-s-data-scientist-job-market-in-2018/).

### Some ideas for working successfully remotely with a group

* set up a co-working zoom / slack session

* have an 'installation party' - getting started with the data all together, bring your own drinks and snacks

* some of the group could try cleaning with python/pandas, others can try cleaning/wrangling with SQL, then share and contrast your approaches

* split the task among you - in which case you can share a Trello or Asana kanban board to assign tasks

* share a digital whiteboard to brainstorm ideas

* agree a shared communication method eg whatsapp / slack

* set up (verbal) calls for check-ins - look after each-other and make sure you share any successful techniques you ran into


### Datasource

Heres the data we will be working with:

[Kaggle data source](https://www.kaggle.com/sl6149/data-scientist-job-market-in-the-us?select=alldata.csv)

**HINT** : You will need to first download the data as `.csv` files and load it into your chosen tool, take a look at:

* [mysql.com export/import a table](https://dev.mysql.com/doc/workbench/en/wb-admin-export-import-table.html)

* [Youtube: Importing a table in Sequel Pro](https://www.youtube.com/watch?v=gomATkH9w4Q)

* [DBeaver: Importing/Exporting Data](https://dbeaver.com/docs/wiki/Data-transfer/)


### Expected outcome

1. one data source which combines all the input `.csv`'s (you can use the ALL data set you see in the Kaggle link or practice combining the files), is useable for rapidly running queries to find insights. The data can be in any format you have been working with in the course so far - pandas data frame, `.csv` flat file, MySQL table or MySQL database

2. employ string functions + regexp, Like , case statements to extract common values from strings of different lengths, eg job description

3. insight to include the ability to summarise results by job profile, company, location city, area of the country

4. create new columns : employ Boolean T/F  logic to indicate which roles are closest to big financial or software centres in the US

5. make a decision about **handling NULLs** in the data - fill in values where logical, ignore them or clean them where not

6. any other data cleaning or wrangling tasks you find useful.

7. **'one pager' summary** - including insights, commentary, review of how easy the data was to work with and highlighting any limitations you found in the data set. This can be in pdf, slide, word doc etc... this can be as beautiful or as simple as you like. You will be sharing this with your classmates and the teaching team will provide feedback on your submissions next week. As you effectively have ONLY one page to make your case, you might start by identifying multiple trends and then scale back to focus on just one or two. The main focus of the exercise is on working with messy data, so if you dont find any great data insights, you should feel free to take screen shots of your cleaning procedures and talk about them.  

### In case of questions

... reach out to the LT or TAs!
