library(acs)
library(ggplot2)

## install API key
APIKEY <- api.key.install("7dbf424d492b694ca9de38c3c2b90867d55086be")

## Looking up the right geography
geo.lookup(state="WI", county="Dane", place="Madison")

Madison <- geo.make(state="WI", place = 48000)

## select only the total, car/truck/van, public transport, bicycle, walk variable from table B08006
TransitVars <- acs.lookup(2017, span = 1, table.number = "B08006", dataset = "acs")[c(1,2,8,14,15)]

#fetch actual data for all available year and return them into acs objects
ACSData2017 <- acs.fetch(2017, geography = Madison, 
                         #table.number = "B08006",
                         variable = c("B08006_001", "B08006_002", "B08006_008", "B08006_014", "B08006_015"),
                         dataset = "acs",
                         span = 1,
                         col.names = c("Total", "Motor Vehicle", "Public transit", "Bicycle", "Walked"))

ACSData2016 <- acs.fetch(2016, geography = Madison, 
                     variable = TransitVars,
                     span = 1,
                     col.names = c("Total", "Motor Vehicle", "Public transit", "Bicycle", "Walked"))
ACSData2015 <- acs.fetch(2015, geography = Madison, 
                         variable = TransitVars, 
                         col.names = c("Total", "Motor Vehicle", "Public transit", "Bicycle", "Walked"))
ACSData2014 <- acs.fetch(2014, geography = Madison, 
                         variable = TransitVars, 
                         col.names = c("Total", "Motor Vehicle", "Public transit", "Bicycle", "Walked"))

ACSData2013 <- acs.fetch(2013, geography = Madison, 
                         variable = TransitVars, 
                         col.names = c("Total", "Motor Vehicle", "Public transit", "Bicycle", "Walked"))

ACSData2012 <- acs.fetch(2012, geography = Madison, 
                         variable = TransitVars, 
                         col.names = c("Total", "Motor Vehicle", "Public transit", "Bicycle", "Walked"))

ACSData2011 <- acs.fetch(2011, geography = Madison, 
                         variable = TransitVars, 
                         col.names = c("Total", "Motor Vehicle", "Public transit", "Bicycle", "Walked"))

ACSData2010 <- acs.fetch(2010, geography = Madison, 
                         variable = TransitVars, 
                         col.names = c("Total", "Motor Vehicle", "Public transit", "Bicycle", "Walked"))

ACSData2009 <- acs.fetch(2009, geography = Madison, 
                         variable = TransitVars, 
                         col.names = c("Total", "Motor Vehicle", "Public transit", "Bicycle", "Walked"))



## To get percentages, you have to use this complicated method that I don't fully understand

ModeSharePercent2017 <- apply(ACSData2017[,2:5], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2016[,1], method="proportion",
                              verbose=F)
ModeSharePercent2016 <- apply(ACSData2016[,2:5], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2016[,1], method="proportion",
                              verbose=F)
ModeSharePercent2015 <- apply(ACSData2015[,2:5], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2015[,1], method="proportion",
                              verbose=F)
ModeSharePercent2014 <- apply(ACSData2014[,2:5], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2014[,1], method="proportion",
                              verbose=F)
ModeSharePercent2013 <- apply(ACSData2013[,2:5], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2013[,1], method="proportion",
                              verbose=F)
ModeSharePercent2012 <- apply(ACSData2012[,2:5], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2012[,1], method="proportion",
                              verbose=F)
ModeSharePercent2011 <- apply(ACSData2011[,2:5], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2011[,1], method="proportion",
                              verbose=F)
ModeSharePercent2010 <- apply(ACSData2010[,2:5], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2010[,1], method="proportion",
                              verbose=F)
ModeSharePercent2009 <- apply(ACSData2009[,2:5], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2009[,1], method="proportion",
                              verbose=F)


## You can access things in the acs objects with the @ operator
## Let's construct a new variable that contains the years as rows and just bike mode
## mode share for now
## you can access things in objects with the @ operator
## the data.frame() function will allow to create the new data frame
## maybe I also need the as.numeric function

## first we extract vectors with just the mode share numbers for each year
## this produces vectors with numeric data

modeShare2016 <- ModeSharePercent2016@estimate
modeShare2015 <- ModeSharePercent2015@estimate
modeShare2014 <- ModeSharePercent2014@estimate
modeShare2013 <- ModeSharePercent2013@estimate
modeShare2012 <- ModeSharePercent2012@estimate
modeShare2011 <- ModeSharePercent2011@estimate
modeShare2010 <- ModeSharePercent2010@estimate
modeShare2009 <- ModeSharePercent2009@estimate

errorShare2016 <- ModeSharePercent2016@standard.error
errorShare2015 <- ModeSharePercent2015@standard.error
errorShare2014 <- ModeSharePercent2014@standard.error
errorShare2013 <- ModeSharePercent2013@standard.error
errorShare2012 <- ModeSharePercent2012@standard.error
errorShare2011 <- ModeSharePercent2011@standard.error
errorShare2010 <- ModeSharePercent2010@standard.error
errorShare2009 <- ModeSharePercent2009@standard.error


##create a new variable for year, starting at 2016 and counting down to 2009
year <- c(seq(2009, 2016, by=1))

## combine the years of mode share data into one vector
ModeShare <- rbind(modeShare2009, modeShare2010, modeShare2011, modeShare2012, 
                        modeShare2013,modeShare2014, modeShare2015,modeShare2016)

ModeError <- rbind(errorShare2009, errorShare2010, errorShare2011, errorShare2012,
                   errorShare2013, errorShare2014, errorShare2015, errorShare2016)

## change name of the rows to the years
row.names(ModeShare) <- year
row.names(ModeError) <- year
## convert into a data frame

ModeShare <- as.data.frame(ModeShare)
ModeError <- as.data.frame(ModeError)



## add a column for the year variable
ModeShare <- cbind(ModeShare, year)
ModeError <- cbind(ModeError, year)


ModeCombined <- merge(ModeShare, ModeError)

##Now let's try plotting the bike mode share by year
g <- plot(ModeShare$`( Bicycle / Total )` ~ ModeShare$year, type = "o", ylim = c(0,0.06))

g <- barplot(ModeShare[,3])

g <- ggplot(data = ModeShare, aes(, ModeShare$`( Bicycle / Total )`), color = "red") + geom_point()


