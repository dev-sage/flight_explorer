# Name: flight_functions
# Purpose: utility functions for analysis.
library(geosphere)
library(maps)
library(ggplot2)
library(rgdal)

getGCs <- function(routes_df) {
  gc_df <- data.frame()
  for(i in 1:nrow(routes_df)) {
    current_route <- as.data.frame(
      gcIntermediate(
        c(routes_df$LON_ORIG[i], routes_df$LAT_ORIG[i]),
          c(routes_df$LON_DEST[i], routes_df$LAT_DEST[i]), 
            n = 20, addStartEnd = FALSE))
    current_route$line <- i
    gc_df <- rbind(gc_df, current_route)
  }
  return(gc_df)
}

getRoutes <- function(airportID) {
  airport_list <- data.frame(destination_airport = ROUTES$DestinationAirport[ROUTES$SourceAirport == airportID])
  airport_list$destination_airport <- as.character(airport_list$destination_airport)
  airport_list %>% left_join(AIRPORTS, by = c("destination_airport" = "IATA_FAA")) -> destination_airports
  source_airport <- AIRPORTS[AIRPORTS$IATA_FAA == airportID, ]
  routes_df <- cbind(source_airport, destination_airports)
  colnames(routes_df) <- c("IATA_ORIG", "ICAO_ORIG", "LAT_ORIG", "LON_ORIG",
                           "IATA_DEST", "ICAO_DEST", "LAT_DEST", "LON_DEST")
  return(routes_df)
}

x <- getRoutes("IAH")
coords <- getGCs(x)
setwd('~/Google_Drive/Flight Explorer/flight_explorer/data/shape_stuff')
shape_data <- readOGR(dsn = '.', layer = 'ne_110m_land')
map_f <- fortify(shape_data)

ggplot(map_f, aes(long, lat, group = group)) + geom_path(size = 0.5) + theme_void()

