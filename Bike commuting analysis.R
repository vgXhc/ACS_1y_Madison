library(acs)
library(ggplot2)
library(reshape2)



## install API key
APIKEY <- api.key.install("7dbf424d492b694ca9de38c3c2b90867d55086be")

## Looking up the right geography
geo.lookup(state="WI", county="Dane", place="Madison")

Madison <- geo.make(state="WI", place = 48000)

## select only the total, car/truck/van, public transport, bicycle, walked, worked at home variable from table B08006
TransitVars <- acs.lookup(2017, span = 1, table.number = "B08006", dataset = "acs")[c(1,2,8,14,15,17)]

# read data from files downloaded from FactFinder
ACSData2017 <- read.acs("data/ACS_17_1YR_B08006_with_ann.csv", endyear = 17, span = 1)
ACSData2016 <- read.acs("data/ACS_16_1YR_B08006_with_ann.csv", endyear = 16, span = 1)
ACSData2015 <- read.acs("data/ACS_15_1YR_B08006_with_ann.csv", endyear = 15, span = 1)
ACSData2014 <- read.acs("data/ACS_14_1YR_B08006_with_ann.csv", endyear = 14, span = 1)
ACSData2013 <- read.acs("data/ACS_13_1YR_B08006_with_ann.csv", endyear = 13, span = 1)
ACSData2012 <- read.acs("data/ACS_12_1YR_B08006_with_ann.csv", endyear = 12, span = 1)
ACSData2011 <- read.acs("data/ACS_11_1YR_B08006_with_ann.csv", endyear = 11, span = 1)
ACSData2010 <- read.acs("data/ACS_10_1YR_B08006_with_ann.csv", endyear = 10, span = 1)
ACSData2009 <- read.acs("data/ACS_09_1YR_B08006_with_ann.csv", endyear = 09, span = 1)
ACSData2008 <- read.acs("data/ACS_08_1YR_B08006_with_ann.csv", endyear = 08, span = 1)
ACSData2007 <- read.acs("data/ACS_07_1YR_B08006_with_ann.csv", endyear = 07, span = 1)
ACSData2006 <- read.acs("data/ACS_06_EST_B08006_with_ann.csv", endyear = 06, span = 1)


## To get percentages with the correct margins of error, 
## you have to use this complicated method; calculating percentages for motor vehicle, drive alone,
## public transit, bicycle, walked, worked at home

ModeSharePercent2017 <- apply(ACSData2017[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2017[,1], method="proportion",
                              verbose=F)
ModeSharePercent2016 <- apply(ACSData2016[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2016[,1], method="proportion",
                              verbose=F)
ModeSharePercent2015 <- apply(ACSData2015[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2015[,1], method="proportion",
                              verbose=F)
ModeSharePercent2014 <- apply(ACSData2014[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2014[,1], method="proportion",
                              verbose=F)
ModeSharePercent2013 <- apply(ACSData2013[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2013[,1], method="proportion",
                              verbose=F)
ModeSharePercent2012 <- apply(ACSData2012[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2012[,1], method="proportion",
                              verbose=F)
ModeSharePercent2011 <- apply(ACSData2011[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2011[,1], method="proportion",
                              verbose=F)
ModeSharePercent2010 <- apply(ACSData2010[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2010[,1], method="proportion",
                              verbose=F)
ModeSharePercent2009 <- apply(ACSData2009[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2009[,1], method="proportion",
                              verbose=F)
ModeSharePercent2008 <- apply(ACSData2008[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2008[,1], method="proportion",
                              verbose=F)
ModeSharePercent2007 <- apply(ACSData2007[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2007[,1], method="proportion",
                              verbose=F)
ModeSharePercent2006 <- apply(ACSData2006[,c(2,3,8,14,15,17)], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2006[,1], method="proportion",
                              verbose=F)
## You can access things in the acs objects with the @ operator
## Let's construct a new variable that contains the years as rows and just bike mode
## mode share for now
## you can access things in objects with the @ operator
## the data.frame() function will allow to create the new data frame

## first we extract vectors with just the mode share numbers for each year
## this produces vectors with numeric data. Use rbind to combine them
ModeShare <- rbind(ModeSharePercent2017@estimate,
                   ModeSharePercent2016@estimate,
                   ModeSharePercent2015@estimate,
                   ModeSharePercent2014@estimate,
                   ModeSharePercent2013@estimate,
                   ModeSharePercent2012@estimate,
                   ModeSharePercent2011@estimate,
                   ModeSharePercent2010@estimate,
                   ModeSharePercent2009@estimate,
                   ModeSharePercent2008@estimate,
                   ModeSharePercent2007@estimate,
                   ModeSharePercent2006@estimate)

ModeError <- rbind(ModeSharePercent2017@standard.error,
                   ModeSharePercent2016@standard.error,
                   ModeSharePercent2015@standard.error,
                   ModeSharePercent2014@standard.error,
                   ModeSharePercent2013@standard.error,
                   ModeSharePercent2012@standard.error,
                   ModeSharePercent2011@standard.error,
                   ModeSharePercent2010@standard.error,
                   ModeSharePercent2009@standard.error,
                   ModeSharePercent2008@standard.error,
                   ModeSharePercent2007@standard.error,
                   ModeSharePercent2006@standard.error)

# change names for variable in both ModeShare and ModeError
colnames(ModeShare) <- c("Motor vehicle", "Drove alone", "Transit", "Bicycle", "Walked", "Worked from home")
colnames(ModeError) <- c("SE Motor Vehicle", "SE Drove alone", "SE Transit", "SE Bicycle", "SE Walked", "SE Worked from home")

## convert into a data frame

ModeShare <- as.data.frame(ModeShare)
ModeError <- as.data.frame(ModeError)

##create a new variable for year, starting at 2017 and counting down to 2006
year <- c(seq(2006, 2017, by=1))
## add a column for the year variable
ModeShare <- cbind(ModeShare, year)
ModeError <- cbind(ModeError, year)

# merge into combined data frame
ModeCombined <- merge(ModeShare, ModeError)

#create variables for upper abd lower bounds of confidence intervals for each mode share variable
ModeCombined$MVmin <- ModeCombined$`Motor vehicle` - ModeCombined$`SE Motor Vehicle`
ModeCombined$MVmax <- ModeCombined$`Motor vehicle` + ModeCombined$`SE Motor Vehicle`

ModeCombined$DrvAlnmin <- ModeCombined$`Drove alone` - ModeCombined$`SE Drove alone`
ModeCombined$DrvAlnmax <- ModeCombined$`Drove alone` + ModeCombined$`SE Drove alone`

ModeCombined$PTmin <- ModeCombined$Transit - ModeCombined$`SE Transit`
ModeCombined$PTmax <- ModeCombined$Transit + ModeCombined$`SE Transit`

ModeCombined$Bikemin <- ModeCombined$Bicycle - ModeCombined$`SE Bicycle`
ModeCombined$Bikemax <- ModeCombined$`Bicycle` + ModeCombined$`SE Bicycle`

ModeCombined$Walkmin <- ModeCombined$Walked - ModeCombined$`SE Walked`
ModeCombined$Walkmax <- ModeCombined$Walked + ModeCombined$`SE Walked`

ModeCombined$Homemin <- ModeCombined$`Worked from home` - ModeCombined$`SE Worked from home`
ModeCombined$Homemax <- ModeCombined$`Worked from home` + ModeCombined$`SE Worked from home`

# I'm trying to melt the data in ModeCombined to get from a wide to a long format

ModeCombined_long <- melt(ModeCombined, 
                          id = "year", 
                          measure.vars = c("Motor vehicle", "Bicycle", "Transit", "Worked from home", "Walked"))

ggplot(data=ModeCombined_long,
       aes(x=year, y=value, colour=variable)) +
  geom_line() +
  xlab("Year") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) + 
  scale_y_continuous(labels = scales::percent, limits = c(0,0.8))

ggplot() +
  geom_area(data = ModeCombined_long, aes(x= year, y = value, fill = variable)) +
  ylab("Mode share") +
  scale_y_continuous(labels = scales::percent) +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2)))



##Now let's try plotting the bike mode share by year

g <- ggplot(data = ModeCombined, 
            aes(x = ModeCombined$year, 
                y = ModeCombined$Bicycle)) + 
            geom_point() + 
            geom_line() +
            ggtitle("Biking") +
            xlab("Year") +
            ylab("Biking to work") +
            scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
            scale_y_continuous(labels = scales::percent, limits = c(0,0.08)) +
            #geom_linerange(aes(ymin = ModeCombined$Bikemin , ymax = ModeCombined$Bikemax)) +
            geom_errorbar(aes(ymin =ModeCombined$Bikemin, ymax = ModeCombined$Bikemax))
g

## plot for drive alone

g <- ggplot(data = ModeCombined, 
            aes(x = ModeCombined$year, 
                y = ModeCombined$`Drove alone`)) + 
  geom_point() + 
  geom_line() +
  xlab("Year") +
  ylab("Driving alone to work") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(labels = scales::percent, limits = c(0.5,0.8)) +
  geom_errorbar(aes(ymin =ModeCombined$DrvAlnmin, ymax = ModeCombined$DrvAlnmax))
g

## plot for motor vehicle

g <- ggplot(data = ModeCombined, 
            aes(x = ModeCombined$year, 
                y = ModeCombined$`Motor vehicle`)) + 
  geom_point() + 
  geom_line() +
  xlab("Year") +
  ylab("Driving to work") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(labels = scales::percent, limits = c(0,0.8)) +
  geom_errorbar(aes(ymin =ModeCombined$MVmin, ymax = ModeCombined$MVmax))
g


## plot for public transit
g <- ggplot(data = ModeCombined, 
            aes(x = ModeCombined$year, 
                y = ModeCombined$Transit)) + 
  geom_point() + 
  geom_line() +
  xlab("Year") +
  ylab("Public transit to work") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(labels = scales::percent, limits = c(0.05,0.15)) +
  geom_errorbar(aes(ymin =ModeCombined$PTmin, ymax = ModeCombined$PTmax))
g



