
if(!require(dplyr)){install.packages("dplyr")}
if(!require(tidyr)){install.packages("tidyr")}
if(!require(writexl)){install.packages("readxl")}


measurementFacts_wide<-readxl::read_excel("Datos_Fito_Final.xlsx", sheet = "measurementFacts", na = "NA")

class(measurementFacts_wide$Transparencia)

measurementFacts_wide_to_long <- tidyr::pivot_longer(measurementFacts_wide, 
                                    cols = 2:20,
                                    names_to = "measurementType",
                                    values_to = "measurementValue")


measurementFacts_wide_to_long<-measurementFacts_wide_to_long %>% mutate(measurementUnit  =
                                        ifelse(measurementType == "Transparencia","m",
                                               ifelse(measurementType == "Temperatura", "°C",
                                                      ifelse(measurementType == "Salinidad", "PSU",
                                                             ifelse(measurementType == "pH", "pH",
                                                                    ifelse(measurementType == "NH4", "µM",
                                                                           ifelse(measurementType == "NO2", "µM",
                                                                                  ifelse(measurementType == "NO3", "µM",
                                                                                         ifelse(measurementType == "PO4", "µM",
                                                                                                ifelse(measurementType == "SiO3", "µM",
                                                                                                       ifelse(measurementType == "Clorofila", "g.m¯³",
                                                                                                              ifelse(measurementType == "Solidos Suspendidos", "g.mL¯³",
                                                                                                                     ifelse(measurementType == "BioVolumen_300um", "ml.1000m¯³",
                                                                                                                            ifelse(measurementType == "Peso.Humedo_300um", "g.1000m¯³",
                                                                                                                                   ifelse(measurementType == "Peso.Seco_300um", "g.1000m¯³",
                                                                                                                                          ifelse(measurementType == "Peso.Sin.Ceniza_300um", "g.1000m¯³",
                                                                                                                                                 ifelse(measurementType == "BioVolumen_500um", "ml.1000m¯³",
                                                                                                                                                        ifelse(measurementType == "Peso.Humedo_500um", "g.1000m¯³",
                                                                                                                                                               ifelse(measurementType == "Peso.Seco_500um", "g.1000m¯³",
                                                                                                                                                                      ifelse(measurementType == "Peso.Sin.Ceniza_500um", "g.1000m¯³",""
                                                                                                                                                                             
                                                        
                                                      ))))))))))))))))))))


measurementFacts_tablaMerge<-base::merge(measurementFacts_wide_to_long, eventoTable, by="fieldNumber")

measurementFacts_tablaMerge2<-base::merge(measurementFacts_tablaMerge, DwC, by="eventID")

measure_Tabla_Final<-measurementFacts_tablaMerge2 %>% dplyr::select(occurrenceID, eventID,measurementType,measurementValue, measurementUnit)


write.table(
  measure_Tabla_Final, 
  file = "../DwC/measurementFacts.csv", 
  col.names = TRUE, 
  row.names = FALSE, 
  sep = ",", 
  fileEncoding = "UTF-8",
  na = "")
