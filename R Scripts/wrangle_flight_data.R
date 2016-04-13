library(readr)
library(dplyr)

# Read in Data from URL
AIRPORTS <- read_csv("https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat", col_names = FALSE)
colnames(AIRPORTS) <- c("Airport ID", "Name", "City", "Country", "IATA_FAA", "ICAO",
                        "Latitude", "Longitude", "Altitude", "Timezone", "DST", "tz_olson")
AIRPORTS %>% arrange(IATA_FAA) -> AIRPORTS
AIRPORTS <- AIRPORTS[, 5:8] # Only keep columns of interest.

AIRLINES <- read_csv("https://raw.githubusercontent.com/jpatokal/openflights/master/data/airlines.dat", col_names = FALSE)
colnames(AIRLINES) <- c("AirlineID", "Name", "Alias", "IATA", "ICAO", "Country", "Active")


ROUTES <- read_csv("https://raw.githubusercontent.com/jpatokal/openflights/master/data/routes.dat", col_names = FALSE)
colnames(ROUTES) <- c("Airline", "AirlineID", "SourceAirport", "SourceID", "DestinationAirport",
                      "DestinationID", "CodeShare", "Stops", "Equipment")
