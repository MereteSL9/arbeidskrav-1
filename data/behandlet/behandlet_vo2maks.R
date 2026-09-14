library(readxl)
library(tidyverse)
library(lubridate)

raadata <- read_excel("data/raa/raadata_vo2maks.xlsx")

data_behandlet <- raadata |> 
  filter(deltager %in% c("P01", "P02", "P03", "P04", "P05", "P06")) |> 
  
  mutate(
    dato = as_date(dato),
    starttidspunkt = format(starttidspunkt, "%H:%M:%S"),
    starttidspunkt = if_else(starttidspunkt < "10:00:00", "Morgen", "Kveld")
  ) |> 
  
  select(deltager, 
         dato, 
         alder,
         starttidspunkt, 
         VO2_maks_rel,
         VO2_maks_abs, 
         HF_maks, 
         la_maks, 
         RER_maks,
         kjonn,
         borg_maks) |> 
  
  print()

write.csv(data_behandlet, 
          file = "./data/behandlet/behandlet_vo2maks.csv", 
          row.names = FALSE)

