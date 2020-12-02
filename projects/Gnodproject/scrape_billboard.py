#!/usr/bin/env python
# coding: utf-8

# In[8]:


# scrape_billboard() scrapes the Billboard's Hot 100 and retrieves the songs name &
# artist, as well as the last week ranks, the peak rank and the weeks on chart

def scrape_billboard():
    # 1. import libraries
    from bs4 import BeautifulSoup
    import requests
    import pandas as pd
    
    # 2. find url and store it in a variable
    url = "https://www.billboard.com/charts/hot-100"
    
    # 3. download html with a get request
    response = requests.get(url)
    if response.status_code != 200:
        print("Scraping failed. Status code " + str(response.status_code))
    
    # 4. parse html (create the 'soup')
    soup = BeautifulSoup(response.content, "html.parser")
    soup.select("#main > div > span > div > div > div.lister > table > tbody > tr:nth-child(1) > td.titleColumn > a")

    # 5. retrieve/extract the desired info
    # song titles
    songs = soup.find_all("span", class_="chart-element__information__song text--truncate color--primary")
    # artists
    artists = soup.find_all("span", class_="chart-element__information__artist text--truncate color--secondary")
    # last week
    last_week_ranks = soup.find_all("span", class_= "chart-element__meta text--center color--secondary text--last")
    # peak rank
    peak_ranks = soup.find_all("span", class_= "chart-element__meta text--center color--secondary text--peak")
    # weeks on chart
    weeks_on_chart = soup.find_all("span", class_= "chart-element__meta text--center color--secondary text--week")

    for i in [songs, artists, last_week_ranks, peak_ranks, weeks_on_chart]:
        for j in range(len(i)):
            i[j] = i[j].getText()
        
    billboard = pd.DataFrame(
        {"song": songs,
         "artist": artists,
         "last_week_rank": last_week_ranks,
         "peak_rank": peak_ranks,
         "weeks_on_chart": weeks_on_chart})
    return billboard

