#!/usr/bin/env python
# coding: utf-8

# In[6]:


def hot_recommender():
    # import scraping function & random int generator
    from scrape_billboard import scrape_billboard
    from random import randint
    
    # scrape billboard hot 100
    billboard = scrape_billboard()
    
    # ask for song
    song = input("What song do you like? ")
    
    # check if song is on billboard hot 100
    song_row = billboard[billboard["song"].str.contains(song)]
    if len(song_row) == 0:
        print("Your song is not hot")
    else:
        check_song = input("Did you mean " + song_row["song"].values[0] + " by " + song_row["artist"].values[0] + "? ")    
    
        # if song is in billboard hot 100, recommend another random hot song
        if check_song == "yes":
            print("That's a hot song.")
            random_song = randint(0, len(billboard)-1)
            print("You might also like " + billboard["song"][random_song] + " by " + billboard["artist"][random_song])
        else:
            print("Ah, not the one I had in mind.")

