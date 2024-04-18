# Pacotes utilizados 

library(dplyr)
library(tidyverse)
library(srvyr)
library(survay)

# Caminho  do arquivo: 

#list.files("C:/Users/Usuario/Desktop/Dados_censo/data/2010/MG")

# Renomeando as variáveis 

dados_censo <- raw_censo %>%
  rename(
    raca = v0606,
    estado = v0619,
    peso = v0010,
    area_ponde = v0011,
    nasceu_mun = v0618,
    sexo = v0601,
    municipio = v0002,
    tempo_mun = v0624
  ) 

#Peso = peso/10^13 

#Filtrando os dados (está sem o calculo do peso amostral)

migrantes <- filter(dados_censo, 
                    municipio == "06200",
                    nasceu_mun == "3",
                    estado == "1",
                    raca %in% c("1", "2", "4"))


# peso= peso/10^13) 

mean(migrantes$tempo_mun, na.rm = TRUE)


