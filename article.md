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
    
There are some things to note about the question. First, it only asks about travel to /work./ So a student riding to class? Doesn't count. A dad dropping off their kid at school? Doesn't count. Someone getting groceries by bike? Doesn’t count. This is problematic because according to other, more comprehensive surveys, journeys to work only constitute between 15 and 20% of all trips that people make. [^1] Second, there is the qualification about "used for most of the distance." Do you take the bus from the west side to downtown and then ride a BCycle for the rest of the way? That will get counted as a bus trip. And finally, there is the word "usually." So if you ride your bike two days a week and take the bus on the other days, you'd only get counted as a public transit commuter.

Another caution on how to interpret the number is about the margins of error. The American Community Survey can't survey everyone, which means there will be a margin of error to its results. Fortunately we know how large that error, and so we can assess whether a difference in numbers is likely a true difference or due to random noise. (We'll see some of that when looking at the Madison ACS numbers below.)

## Counts
Another way to know how many people bike in Madison is -- to count them. Seems obvious, but there are a lot of issues with this too. The most visible efforts of counting people on bikes are the two Eco Counter displays on the Southwest Path and the Cap City Trail. These counters use sensors in the pavement to count everyone who rides by. In addition to these two counter, the city has the same type of counters without the display in about 20 locations on bike paths across the city.
In addition to these stationary counters, the city used to do so-called screenline counts. Until a couple years ago, volunteers from the Bike Fed would sit at 60 intersections and count all cyclists passing by during a two-hour window. But that takes a lot of resources, and you only get a snapshot that may be influenced by the weather on that particular day or other issues.

There are a problems with the permanent counters as well: We don’t have enough of them, and they are all installed on bike paths and therefore not capturing people riding in the street. Further, several of the counters are not counting year round. In addition, the city makes it very difficult for citizens to access the data from the counters. Instead of making detailed data available in the city’s Open Data portal, all they do is put summary data in a pdf once a year. This means that advocates like us can’t analyze the data in detail and do interesting things with it. For the Eco Counter displays, I’ve gone through the effort of manually writing down the monthly number from the company’s public website.
Compare that to the wealth of data we have about roads and motor vehicles: <https://cityofmadison.maps.arcgis.com/apps/webappviewer/index.html?id=8c2d43c18d8542c7bdf8a93a11d7e545>


# What do the numbers say?
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
 
[^1]: On the other hand, commuting does make up for a disproportionate load on our transportation system: Because much of it takes places during only a few hours of the day -- the morning and evening rush hours -- we often size our transportation systems to accommodate these demand peaks. Many non-commute trips are more evenly distributed throughout the day. This is why we have rush hour parking restrictions, or more frequent bus service during rush hour.