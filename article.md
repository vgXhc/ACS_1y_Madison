---
title: "Biking in Madison: What do we know?"
author: "Harald Kliems"
date: "October 8, 2018"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# How do we know how many people bike in Madison?
We are surrounded by numbers about all kinds of things in the media or in our daily lives. We see unemployment statistics, maps of rainfall or police reports, and election polling. So surely we must have numbers on how many people ride a bike in Madison, right? Well, kind of. There are two main sources of how many people bike: Surveys, where people are being asked about their travel behavior, and actual counts of how many people bike past a specific location.

## Surveys
The most comprehensive survey that provides data about biking in Madison is the American Community Survey (ACS). Every week of the year, a sample of random households are asked questions about their income, living situation, travel habits, and more. The year-round data collection helps prevent seasonal distortions. For example, if you only asked people how they got to work in the second week of January, the number of bike commuters in Madison would appear very low.

For each person in a household, the following question is being asked:

<https://imgur.com/vV6yeuA>

> "How did this person usually get to work LAST WEEK? If this  person used more than one method of transportation during the trip, mark (x) the box of the one used for most of the distance."
    
There are some things to note about the question. First, it only asks about travel to /work./ So a UW student riding to class? Doesn't count. A dad dropping off their kid at school? Doesn't count. Someone getting groceries by bike? Doesn’t count. This is problematic because according to other, more comprehensive surveys, journeys to work only constitute between 15 and 20% of all trips that people make. Second, there is the qualification about "used for most of the distance." Do you take the bus from the west side to downtown and then ride a BCycle for the rest of the way? That will get counted as a bus trip. And finally, there is the word "usually." So if you ride your bike two days a week and take the bus on the other days, you'd only get counted as a public transit commuter.

Another caution on how to interpret the number is about the margins of error. Other than the Census taking place every 10 years, the American Community Survey can't survey everyone. This means there will be a margin of error to its results. Fortunately we know how large that error, and so we can assess whether a difference in numbers is likely a true difference or due to random noise. In general, the shorter the time period and the smaller the geographic unit of analysis, the larger the margin of error will be. So the American Community five-year estimates will be more precise than the one-year ones; and the numbers for the whole of Wisconsin will be more precise than estimates at the neighborhood level. We'll see some of that when looking at the Madison ACS numbers below.

## Counts
Another way to know how many people bike in Madison is -- to count them. Seems obvious, but there are a lot of issues with this too. The most visible efforts of counting people on bikes are the two Eco Counter displays on the Southwest Path and the Cap City Trail. These counters use sensors in the pavement to count everyone who rides by. In addition to these two counters, the city has counters without a display in about 20 locations on bike paths across the city.
In addition to these stationary counters, the city used to do so-called screenline counts. Until a couple years ago, volunteers from the Bike Fed would sit at 60 intersections and count all cyclists passing by during a two-hour window. But that takes a lot of resources, and you only get a snapshot that may be influenced by the weather on that particular day or other issues.

There are problems with the permanent counters as well: We don’t have enough of them, and they are all installed on bike paths and therefore not capturing people riding in the street. Further, several of the counters are not counting year round. In addition, the city makes it very difficult for citizens to access the data from the counters. Instead of making detailed data available in the city’s Open Data portal, all they do is put summary data in a pdf once a year. This means that advocates like us can’t analyze the data in detail and do interesting things with it. For the Eco Counter displays, I’ve gone through the effort of manually writing down the monthly number from the company’s public website.
Compare that to the wealth of data we have about roads and motor vehicles: <https://cityofmadison.maps.arcgis.com/apps/webappviewer/index.html?id=8c2d43c18d8542c7bdf8a93a11d7e545> The good news: The City is working on making more detailed data available in the near future! Stay tuned.

## Other data sources
In addition to the methods above, there are some other data sources available. Much more detailed data about biking and transportation in general -- including non-work trips -- is included in the <https://nhts.ornl.gov/>(National Household Travel Survey). But this survey is only done every 5-10 years, and it is more useful for national or statewide than for local statistics. A relatively recent trend is to use smartphone or app data to understand travel patterns. For example, ride tracking app Strava [https://metro.strava.com/](sells their user data to local municipalities), and there are other companies that use anonymized cell phone tower data, analyzed through machine learning, to track people. Biases in whose data is being used (e.g. Strava users are not representative of the larger biking public), concerns about privacy and cost, and technical problems such as being able to reliably distinguish between, say, a bus and a bike trip, haven't been fully solved yet, and may not be solvable in the short term.

## Conclusion

Lots of data about biking in Madison and elsewhere is available. But it is important to understand the limitations of each data source and then carefully decide which questions can and cannot be answered. For local trends over time, the American Community Survey data is the best option available, despite its shortcomings. In the next post, I will primarily use that data and see what they can tell us about biking in Madison. 

# Biking in Madison What do the numbers say?
In the previous post, I have discussed different sources for data about biking and what some of their advantages and disadvantages are.  But what do the numbers for Madison actually say?

## American Community Survey


### Biking
### Driving
#### Drive alone
### Public transit
### Work at home

# How does Madison compare to other places?

# How do we explain the stagnation?

# Where do people bike?

# What should be done?

## Big Jump project
Industry-funded bike advocacy organization People for Bikes set out to test and see whether it's possible to achieve a big increase in biking numbers. Their Big Jump project "aims to double or triple bike ridership in specific neighborhoods, hopes to prove that when cities make smart changes, more people ride bikes, and communities become better places to live, work and play." Madison unfortunately didn't put in an application, but we will see what lessons can be learned from the successes (and failures) in the communities that did receive funding.
