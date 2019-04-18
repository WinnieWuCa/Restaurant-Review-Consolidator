Background
When traveling to a new city, you want to plan your restaurant reservations.  However, there are many sources to choose from; restaurant critics to restaurant goers.  This database will consolidate from several sources to create a more complete picture of restaurants for a more balanced, definitive view.  

Sources used
Different review sites, attract different user profiles.  The objective for this exercise is to select from a wide variety as follows:
Google reviews
Yelp reviews
Zamato reviews 

Focus
New York top restaurants  

Common Fields 
Restaurant name
Restaurant phone number 
Restaurant postal code
Restaurant address  
Restaurant city
Restaurant rating
Restaurant categories (cuisine type like Mexican, Thai, Chinese)
Restaurant cost  
Review count

Discovery Process

Initial scope: to cover 5 major cities: Toronto, New York, London, Paris and  Tokyo. 
Final scope: reduced to focus on New York due to time constraint and data limitation in Zamoto.  

Data Extract

Google - Haneul via Google API 
Yelp - Winnie via Yelp API
Zamato - Avis via web scraping 

Data Transformation  
Google  
Given the objective to focus on top restaurants, API call was set to return only the top restaurants with rating >=4.0. 
Price field was transformed to be consistent with the format with Yelp ($, $$, $$$, etc).

Yelp:  
By default, an API call returns a result of 20. This was overcome by changing the parameter passed through API. 
Given the objective to focus on top restaurants, API call was set to return only the top 50 restaurants with rating >=4.0.  
Cost was not always available for each restaurant. When that happened, API data retrieval would end in error and stopped retrieving more data. As a result, additional error handling had to be added. 
Data cleaning: Address was returned with “[ ]” resulting in error “Error Code: 1241. Operand should contain 1 column(s) when data was being added to the table. Address field was converted to string and str.replace was used to remove “[ ]”.  Phone number was returned with prefix “+1”. This was not consistent with the format for Phone Number returned from Zamato. As a result, Phone Number field was also converted to string and str.replace was used to remove “+1”.

Zomato - the address field and vote fields needed to be cleaned of extra data so that it would meet the project standard.  

Data Tables
A separate table was created from each data source:
Yelp - pulled through the Yelp api.  A list of cities was pulled based on the original requirement.  The data was standardized and the New York City data was passed.
Google - pulled through the google api.  A dataframe was created and the data was cleansed, standardized and a final dataframe created.
Zomato - pulled through screen scraping on the list of “Must Visit Restaurants Collection”.  All the restaurants, ratings and individual restaurant urls were pulled in the first loop and then a second loop was built to screen scrape the additional details required from each restaurant’s individual page.  The data was cleansed, standardized and a final dataframe created.
Matching
The Yelp and Zomato data was joined on telephone number as each restaurant from these two sources contain a telephone number
The Google data is joined to the dataframe first on a telephone number match and if there is no telephone number, a Yelp.name and Yelp.postal code match.  The Zomato data was the most inconsistent so Yelp was used instead.
The telephone number was edited so that all characters were removed leaving only a 7-digit number

Final Database
Due to the time constraint, we had a relatively simple scope. As a result we chose sql and mysql, since it is simple and efficient to code.  
Not every field was available from each site, the consolidator enables more complete data to be presented to the end user. The final data set was primarily based on results from Yelp and enriched with results from Google and Zamato.   

