library(readr)
library(dplyr)

# Read in Data from URL
airports <- read_csv("https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat",
                     col_names = FALSE)
colnames(airports) <- c("Airport ID", "Name", "City", "Country", "IATA_FAA", "ICAO",
                        "Latitude", "Longitude", "Altitude", "Timezone", "DST", "tz_olson")

airlines <- read_csv("https://raw.githubusercontent.com/jpatokal/openflights/master/data/airlines.dat",
                     col_names = FALSE)
colnames(airlines) <- c("AirlineID", "Name", "Alias", "IATA", "ICAO", "Country", "Active")


routes <- read_csv("https://raw.githubusercontent.com/jpatokal/openflights/master/data/routes.dat",
                   col_names = FALSE)
colnames(routes) <- c("Airline", "AirlineID", "SourceAirport", "SourceID", "DestinationAirport",
                      "DestinationID", "CodeShare", "Stops", "Equipment")
