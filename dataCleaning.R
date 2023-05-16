libary(readr)
setwd("/Users/kdot/Data-Science-Project")
data <- read_csv("NYPD_Shooting_Incident_Data__Year_To_Date.csv", stringAsFactors = FALSE)
#view structure
str(data)
#Missing Values
data[data == "(null)"] <- NA
colSums(is.na(data))
#Handling Missing Data
#Impute median for Borough, City Council, Police, Zip, Community, Longitude, Latitude, and New.GEO
#calculating medians
median_borough <- median(data$Borough.Boundaries, na.rm = TRUE)
median_CityCouncil <- median(data$City.Council.Districts, na.rm = TRUE)
median_policePrecinct <- median(data$Police.Precincts, na.rm = TRUE)
median_zipCode <- median(data$Zip.Codes, na.rm = TRUE)
median_communityDistrict <- median(data$Community.Districts, na.rm = TRUE)
median_longitude <- median(data$Longitude, na.rm = TRUE)
median_latitude <- median(data$Latitude, na.rm = TRUE)
mode_newGeo <- names(which.max(table(data$New.Georeferenced.Column)))
#Impute missing values
data$Borough.Boundaries[is.na(data$Borough.Boundaries)] <- median_borough
data$City.Council.Districts[is.na(data$City.Council.Districts)] <- median_CityCouncil
data$Police.Precincts[is.na(data$Police.Precincts)] <- median_policePrecinct
data$Zip.Codes[is.na(data$Zip.Codes)] <- median_zipCode
data$Community.Districts[is.na(data$Community.Districts)] <- median_communityDistrict
data$Longitude[is.na(data$Longitude)] <- median_longitude
data$Latitude[is.na(data$Latitude)] <- median_latitude
data$New.Georeferenced.Column[is.na(data$New.Georeferenced.Column)] <- mode_newGeo
colSums(is.na(data))
#Dropping Location_Desc since we have Loc_Class
data <- subset(data, select = -LOCATION_DESC)
data$LOCATION_DESC <- NULL
colSums(is.na(data))
# Setting NA values of PERP to Unknown
data$PERP_AGE_GROUP[is.na(data$PERP_AGE_GROUP)] <- "Unknown"
data$PERP_SEX[is.na(data$PERP_SEX)] <- "Unknown"
data$PERP_RACE[is.na(data$PERP_RACE)] <- "Unknown"
colSums(is.na(data))
#Data is Cleaned
