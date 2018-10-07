library(acs)
library(ggplot2)

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
## maybe I also need the as.numeric function

## first we extract vectors with just the mode share numbers for each year
## this produces vectors with numeric data

modeShare2017 <- ModeSharePercent2017@estimate
modeShare2016 <- ModeSharePercent2016@estimate
modeShare2015 <- ModeSharePercent2015@estimate
modeShare2014 <- ModeSharePercent2014@estimate
modeShare2013 <- ModeSharePercent2013@estimate
modeShare2012 <- ModeSharePercent2012@estimate
modeShare2011 <- ModeSharePercent2011@estimate
modeShare2010 <- ModeSharePercent2010@estimate
modeShare2009 <- ModeSharePercent2009@estimate

errorShare2017 <- ModeSharePercent2017@standard.error
errorShare2016 <- ModeSharePercent2016@standard.error
errorShare2015 <- ModeSharePercent2015@standard.error
errorShare2014 <- ModeSharePercent2014@standard.error
errorShare2013 <- ModeSharePercent2013@standard.error
errorShare2012 <- ModeSharePercent2012@standard.error
errorShare2011 <- ModeSharePercent2011@standard.error
errorShare2010 <- ModeSharePercent2010@standard.error
errorShare2009 <- ModeSharePercent2009@standard.error


##create a new variable for year, starting at 2016 and counting down to 2009
year <- c(seq(2009, 2017, by=1))

## combine the years of mode share data into one vector
ModeShare <- rbind(modeShare2009, modeShare2010, modeShare2011, modeShare2012, 
                        modeShare2013,modeShare2014, modeShare2015,modeShare2016, modeShare2017)

ModeError <- rbind(errorShare2009, errorShare2010, errorShare2011, errorShare2012,
                   errorShare2013, errorShare2014, errorShare2015, errorShare2016, errorShare2017)

colnames(ModeError) <- c("SE Motor Vehicle", "SE Public Transit", "SE Bicycle", "SE Walked")
## change name of the rows to the years
#row.names(ModeShare) <- year
#row.names(ModeError) <- year
## convert into a data frame

ModeShare <- as.data.frame(ModeShare)
ModeError <- as.data.frame(ModeError)


## add a column for the year variable
ModeShare <- cbind(ModeShare, year)
ModeError <- cbind(ModeError, year)


ModeCombined <- merge(ModeShare, ModeError)
#add variables for minimum and maximum
ModeCombined$bike_min <- ModeCombined$`( Bicycle / Total )` - ModeCombined$`SE Bicycle`
ModeCombined$bike_max <- ModeCombined$`( Bicycle / Total )` + ModeCombined$`SE Bicycle`
##Now let's try plotting the bike mode share by year
g <- plot(ModeShare$`( Bicycle / Total )` ~ ModeShare$year, type = "o", ylim = c(0,0.06))

g <- barplot(ModeShare[,3])

g <- ggplot(data = ModeCombined, 
            aes(x = ModeCombined$year, 
                y = ModeCombined$`( Bicycle / Total )`, 
                color = "red")) + 
            geom_point() + 
            geom_line(color = "blue") +
            theme_classic() +
            xlab("Year") +
            ylab("Percent biking to work") +
            scale_y_continuous(labels = scales::percent, limits = c(0,0.08)) +
            geom_linerange(aes(ymin = ModeCombined$bike_min, ymax = ModeCombined$bike_max))
g

