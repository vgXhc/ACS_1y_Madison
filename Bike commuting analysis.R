library(acs)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(tidyverse)

######################
######################
## Data prep        ## 
######################
######################


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


#create a data frame with just the motor vehicle and total numbers by year
MVnumbers <- rbind(ACSData2006@estimate[1:2],
                   ACSData2007@estimate[1:2],
                   ACSData2008@estimate[1:2],
                   ACSData2009@estimate[1:2],
                   ACSData2010@estimate[1:2],
                   ACSData2011@estimate[1:2],
                   ACSData2012@estimate[1:2],
                   ACSData2013@estimate[1:2],
                   ACSData2014@estimate[1:2],
                   ACSData2015@estimate[1:2],
                   ACSData2016@estimate[1:2],
                   ACSData2017@estimate[1:2])



## To get percentages with the correct margins of error, 
## you have to use this complicated method; calculating percentages for motor vehicle, drive alone,
## public transit, bicycle, walked, worked at home
## Also adding data for male/female 
# Relevant variables: 
# Male:
# - Total: 18
# - MV: 19
# - DrvAln: 20
# - Bike: 31
# Female:
# - Total: 35
# - MV: 37
# - DrvAln: 37
# - Bike: 48
VariableList <- c(2,3,8,14,15,17)

ModeSharePercent2017 <- apply(ACSData2017[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2017[,1], method="proportion",
                              verbose=F)
ModeSharePercent2016 <- apply(ACSData2016[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2016[,1], method="proportion",
                              verbose=F)
ModeSharePercent2015 <- apply(ACSData2015[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2015[,1], method="proportion",
                              verbose=F)
ModeSharePercent2014 <- apply(ACSData2014[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2014[,1], method="proportion",
                              verbose=F)
ModeSharePercent2013 <- apply(ACSData2013[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2013[,1], method="proportion",
                              verbose=F)
ModeSharePercent2012 <- apply(ACSData2012[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2012[,1], method="proportion",
                              verbose=F)
ModeSharePercent2011 <- apply(ACSData2011[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2011[,1], method="proportion",
                              verbose=F)
ModeSharePercent2010 <- apply(ACSData2010[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2010[,1], method="proportion",
                              verbose=F)
ModeSharePercent2009 <- apply(ACSData2009[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2009[,1], method="proportion",
                              verbose=F)
ModeSharePercent2008 <- apply(ACSData2008[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2008[,1], method="proportion",
                              verbose=F)
ModeSharePercent2007 <- apply(ACSData2007[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2007[,1], method="proportion",
                              verbose=F)
ModeSharePercent2006 <- apply(ACSData2006[,VariableList], MARGIN=1, FUN=divide.acs,
                              denominator=ACSData2006[,1], method="proportion",
                              verbose=F)

# Proportions for male and female
# These have to be calculcated separately as they have a different denominator each
VariableList <- c(19,20,31)


MaleModeSharePercent2017 <- apply(ACSData2017[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2017[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2016 <- apply(ACSData2016[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2016[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2015 <- apply(ACSData2015[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2015[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2014 <- apply(ACSData2014[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2014[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2013 <- apply(ACSData2013[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2013[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2012 <- apply(ACSData2012[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2012[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2011 <- apply(ACSData2011[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2011[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2010 <- apply(ACSData2010[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2010[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2009 <- apply(ACSData2009[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2009[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2008 <- apply(ACSData2008[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2008[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2007 <- apply(ACSData2007[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2007[,18], method="proportion",
                                  verbose=F)
MaleModeSharePercent2006 <- apply(ACSData2006[,VariableList], MARGIN=1, FUN=divide.acs,
                                  denominator=ACSData2006[,18], method="proportion",
                                  verbose=F)

VariableList <- c(36,37,48)
FemaleModeSharePercent2017 <- apply(ACSData2017[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2017[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2016 <- apply(ACSData2016[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2016[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2015 <- apply(ACSData2015[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2015[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2014 <- apply(ACSData2014[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2014[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2013 <- apply(ACSData2013[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2013[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2012 <- apply(ACSData2012[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2012[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2011 <- apply(ACSData2011[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2011[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2010 <- apply(ACSData2010[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2010[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2009 <- apply(ACSData2009[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2009[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2008 <- apply(ACSData2008[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2008[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2007 <- apply(ACSData2007[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2007[,35], method="proportion",
                                    verbose=F)
FemaleModeSharePercent2006 <- apply(ACSData2006[,VariableList], MARGIN=1, FUN=divide.acs,
                                    denominator=ACSData2006[,35], method="proportion",
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

FemaleModeShare <- rbind(FemaleModeSharePercent2017@estimate,
                         FemaleModeSharePercent2016@estimate,
                         FemaleModeSharePercent2015@estimate,
                         FemaleModeSharePercent2014@estimate,
                         FemaleModeSharePercent2013@estimate,
                         FemaleModeSharePercent2012@estimate,
                         FemaleModeSharePercent2011@estimate,
                         FemaleModeSharePercent2010@estimate,
                         FemaleModeSharePercent2009@estimate,
                         FemaleModeSharePercent2008@estimate,
                         FemaleModeSharePercent2007@estimate,
                         FemaleModeSharePercent2006@estimate)


MaleModeShare <- rbind(MaleModeSharePercent2017@estimate,
                       MaleModeSharePercent2016@estimate,
                       MaleModeSharePercent2015@estimate,
                       MaleModeSharePercent2014@estimate,
                       MaleModeSharePercent2013@estimate,
                       MaleModeSharePercent2012@estimate,
                       MaleModeSharePercent2011@estimate,
                       MaleModeSharePercent2010@estimate,
                       MaleModeSharePercent2009@estimate,
                       MaleModeSharePercent2008@estimate,
                       MaleModeSharePercent2007@estimate,
                       MaleModeSharePercent2006@estimate)

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

MaleModeError <- rbind(MaleModeSharePercent2017@standard.error,
                       MaleModeSharePercent2016@standard.error,
                       MaleModeSharePercent2015@standard.error,
                       MaleModeSharePercent2014@standard.error,
                       MaleModeSharePercent2013@standard.error,
                       MaleModeSharePercent2012@standard.error,
                       MaleModeSharePercent2011@standard.error,
                       MaleModeSharePercent2010@standard.error,
                       MaleModeSharePercent2009@standard.error,
                       MaleModeSharePercent2008@standard.error,
                       MaleModeSharePercent2007@standard.error,
                       MaleModeSharePercent2006@standard.error)

FemaleModeError <- rbind(FemaleModeSharePercent2017@standard.error,
                         FemaleModeSharePercent2016@standard.error,
                         FemaleModeSharePercent2015@standard.error,
                         FemaleModeSharePercent2014@standard.error,
                         FemaleModeSharePercent2013@standard.error,
                         FemaleModeSharePercent2012@standard.error,
                         FemaleModeSharePercent2011@standard.error,
                         FemaleModeSharePercent2010@standard.error,
                         FemaleModeSharePercent2009@standard.error,
                         FemaleModeSharePercent2008@standard.error,
                         FemaleModeSharePercent2007@standard.error,
                         FemaleModeSharePercent2006@standard.error)


# change names for variable in both ModeShare and ModeError
colnames(ModeShare) <- c("Motor vehicle", "Drove alone", "Transit", "Bicycle", "Walked", "Worked from home")
colnames(ModeError) <- c("SE Motor Vehicle", "SE Drove alone", "SE Transit", "SE Bicycle", "SE Walked", "SE Worked from home")
colnames(MaleModeShare) <- c("Motor vehicle (men)", "Drove Alone (men)", "Bicycle (men)")
colnames(FemaleModeShare) <- c("Motor vehicle (women)", "Drove Alone (women)", "Bicycle (women)")
colnames(MaleModeError) <- c("SE Motor Vehicle (men)", "SE Drove Alone (men)", "SE Bicycle (men)")
colnames(FemaleModeError) <- c("SE Motor Vehicle (women)", "SE Drove Alone (women)", "SE Bicycle (women)")

# change column names for motor vehicle
colnames(MVnumbers) <- c("Total commuters", "Motor vehicle")

## convert into a data frame

ModeShare <- as.data.frame(ModeShare)
ModeError <- as.data.frame(ModeError)
MVnumbers <- as.data.frame(MVnumbers)
FemaleModeError <- as.data.frame(FemaleModeError)
FemaleModeShare <- as.data.frame(FemaleModeShare)
MaleModeError <- as.data.frame(MaleModeError)
MaleModeShare <- as.data.frame(MaleModeShare)

##create a new variable for year, starting at 2017 and counting down to 2006
year <- c(seq(2006, 2017, by=1))
## add a column for the year variable
ModeShare <- cbind(ModeShare, year)
ModeError <- cbind(ModeError, year)
MVnumbers <- cbind(MVnumbers, year)
FemaleModeError <- cbind(FemaleModeError, year)
FemaleModeShare <- cbind(FemaleModeShare, year)
MaleModeError <- cbind(MaleModeError, year)
MaleModeShare <- cbind(MaleModeShare, year)



# merge into combined data frame
ModeCombined <- merge(ModeShare, ModeError)

FemaleModeCombined <- merge(FemaleModeError, FemaleModeShare)
MaleModeCombined <- merge(MaleModeError, MaleModeShare)
GenderModeCombined <- merge(MaleModeCombined, FemaleModeCombined)


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

GenderModeCombined$BicycleMmax <- GenderModeCombined$`Bicycle (men)` + GenderModeCombined$`SE Bicycle (men)`
GenderModeCombined$BicycleMmin <- GenderModeCombined$`Bicycle (men)` - GenderModeCombined$`SE Bicycle (men)`
GenderModeCombined$BicycleFmax <- GenderModeCombined$`Bicycle (women)` + GenderModeCombined$`SE Bicycle (women)`
GenderModeCombined$BicycleFmin <- GenderModeCombined$`Bicycle (women)` + GenderModeCombined$`SE Bicycle (women)`


# melt the data in ModeCombined to get from a wide to a long format

ModeCombined_long <- melt(ModeCombined, 
                          id = "year", 
                          measure.vars = c("Motor vehicle", "Bicycle", "Transit", "Worked from home", "Walked"))


# also melt data in MVnumbers

MVnumbers_long <- melt(MVnumbers,
                       id = "year",
                       measure.vars = c("Total commuters", "Motor vehicle"))



# melt gender data

GenderModeCombined_long <- melt(GenderModeCombined,
                                id = "year",
                                measure.vars = c("Bicycle (men)",
                                                 "Bicycle (women)",
                                                 "BicycleMmax",
                                                 "BicycleMmin",
                                                 "BicycleFmax",
                                                 "BicycleFmin"))

GenderErrorCombined_long <- melt(GenderModeCombined,
                                 id = "year",
                                 measure.vars = c("BicycleMmax",
                                                  "BicycleMmin",
                                                  "BicycleFmax",
                                                  "BicycleFmin"))



######################
######################
## Data plots       ## 
######################
######################


ggplot(MVnumbers_long, aes(x = year, y = value, color = variable)) +
  xlab("Year") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(limits = c(0,150000)) +
  geom_point() +
  geom_smooth()


plotdata <- filter(GenderModeCombined_long, variable %in% c("Bicycle (men)", "Bicycle (women)"))
errordataMmax <- filter(GenderModeCombined_long, variable %in% c("BicycleMmax"))
errordataMmin <- filter(GenderModeCombined_long, variable %in% c("BicycleMmin"))


ggplot(data=plotdata,
       aes(x=year, y=value, colour=variable)) +
  geom_point() +
  geom_line() +
  xlab("Year") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) + 
  scale_y_continuous(labels = scales::percent, limits = c(0,0.15)) +
  geom_errorbar(data = errordataMmax, aes(ymax = value, ymin = value)) +
  geom_errorbar(data = errordataMmin, aes(ymax = value, ymin = value))

ggplot(data=ModeCombined_long,
       aes(x=year, y=value, colour=variable)) +
  geom_point() +
  geom_line() +
  xlab("Year") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) + 
  scale_y_continuous(labels = scales::percent)

ggplot() +
  geom_area(data = ModeCombined_long, aes(x= year, y = value, fill = variable)) +
  ylab("Mode share") +
  scale_y_continuous(labels = scales::percent) +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2)))



##Now let's try plotting the bike mode share by year

bikePlot <- ggplot(data = ModeCombined, 
                   aes(x = ModeCombined$year, 
                       y = ModeCombined$Bicycle)) + 
  geom_point() + 
  geom_line() +
  ggtitle("Bike") +
  xlab("Year") +
  ylab("Biking to work") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(labels = scales::percent) +
  #geom_linerange(aes(ymin = ModeCombined$Bikemin , ymax = ModeCombined$Bikemax)) +
  geom_errorbar(aes(ymin = ModeCombined$Bikemin, ymax = ModeCombined$Bikemax))


## plot for drive alone

drvAlnPlot <- ggplot(data = ModeCombined, 
                     aes(x = ModeCombined$year, 
                         y = ModeCombined$`Drove alone`)) + 
  geom_point() + 
  geom_line() +
  ggtitle("Drive alone") +
  xlab("Year") +
  ylab("Driving alone to work") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(labels = scales::percent) +
  geom_errorbar(aes(ymin =ModeCombined$DrvAlnmin, ymax = ModeCombined$DrvAlnmax))


## plot for motor vehicle

MVPlot <- ggplot(data = ModeCombined, 
                 aes(x = ModeCombined$year, 
                     y = ModeCombined$`Motor vehicle`)) + 
  geom_point() + 
  geom_line() +
  ggtitle("Motor vehicle") +
  xlab("Year") +
  ylab("Driving to work") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(labels = scales::percent) +
  geom_errorbar(aes(ymin =ModeCombined$MVmin, ymax = ModeCombined$MVmax))



## plot for public transit
PTPlot <- ggplot(data = ModeCombined, 
                 aes(x = ModeCombined$year, 
                     y = ModeCombined$Transit)) + 
  geom_point() + 
  geom_line() +
  ggtitle("Public transit") +
  xlab("Year") +
  ylab("Public transit to work") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(labels = scales::percent) +
  geom_errorbar(aes(ymin =ModeCombined$PTmin, ymax = ModeCombined$PTmax))

## plot for walking
walkPlot <- ggplot(data = ModeCombined, 
                   aes(x = ModeCombined$year, 
                       y = ModeCombined$Walked)) + 
  geom_point() + 
  geom_line() +
  ggtitle("Walk") +
  xlab("Year") +
  ylab("Walked to work") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(labels = scales::percent) +
  geom_errorbar(aes(ymin =ModeCombined$Walkmin , ymax = ModeCombined$Walkmax))

## plot for work from home
homePlot <- ggplot(data = ModeCombined, 
                   aes(x = ModeCombined$year, 
                       y = ModeCombined$`Worked from home`)) + 
  geom_point() + 
  geom_line() +
  ggtitle("Work from home") +
  xlab("Year") +
  ylab("Worked from home") +
  scale_x_continuous(breaks = c(seq(from = 2006, to = 2017, by = 2))) +
  scale_y_continuous(labels = scales::percent) +
  geom_errorbar(aes(ymin =ModeCombined$Homemin , ymax = ModeCombined$Homemax))

# create multi-panel plot
grid.arrange(bikePlot, MVPlot, PTPlot, walkPlot, drvAlnPlot, homePlot, nrow = 2, top = "Commute Mode Share in Madison, 2006-2017")