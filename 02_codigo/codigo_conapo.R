# paquetes ----
install.packages(c(readxl, stringr, tidyverse, zoo)) # Sólo necesario en caso de no tener los paquetes instalados
library(tidyverse)
library(stringr)
library(readxl)
library(zoo)

# Generar vector que almacenará los nombres de todos los archivos en 01_datos ---- 
nom_archivos <- list.files("01_datos")

# Quitar los cinco últimos caracters al nombre de cada archivo ----
nom_df <- str_sub(nom_archivos, 1, str_length(nom_archivos) -5)

# Cargar los archivos de las 32 entidades ----
for(i in nom_df){
  filepath <- file.path("01_datos/", paste(i,".xlsx",sep=""))
  assign(i, read_excel(filepath, skip = 2))
}

# Unir las 32 bases de datos estatales ----
bd <- mget(nom_df)
bd <- bind_rows(bd, .id="nom_df")

# Limpiar y transformar la base de datos ----
bd %>% 
  rename(cve_mpo = "Clave Municipio", # Renombrar varibles
         mpo = "Municipio", 
         sexo = "Sexo", 
         gpo_edad = "Grupos de Edad") %>% 
  filter(!is.na(gpo_edad)) %>% # Remover renglones vacíos entre bloques de datos
  mutate(sexo = na.locf(sexo), # Rellenar las celdas con NA debajo de cada celda no vacía
         cve_mpo = na.locf(cve_mpo), # Rellenar las celdas con NA debajo de cada celda no vacía
         mpo = replace(mpo, nchar(cve_mpo) > 5, "Estado"),
         mpo = trimws(mpo), # Quitar espacios en blanco del principio y el final
         mpo = na.locf(mpo)) %>% # Rellenar las celdas con NA debajo de cada celda no vacía
  gather(colnames(bd)[seq(-1, -5, -1)],
         key = "año",
         value = "valor") %>% 
  mutate(nom_df = str_sub(nom_df, 1, str_length(nom_df) -4)) %>% # Quitar los cuatro últimos caracteres al final de cada campo en la columna nom_df
  rename(edo = nom_df) %>%  # Renombrar la columna nom_df por edo
  print(n = 400
        )

# Guardar bd transformada 
write.csv(bd, "01_datos/proy_pob_mpo_conapo.csv")
