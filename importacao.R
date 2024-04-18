#Pacotes utilizados:

library(lodown)
library(dplyr)
library(magrittr)
library(stringr)
library(fs)
library(SAScii)
library(readr)
library(bitops)
library(bit64)


#Começando a importar:

catalog <- lodown::get_catalog(data_name = "censo", output_dir = "data") |> dplyr::filter(year==2010, stringr::str_detect(state,"mg")) |> lodown:: lodown(data_name = "censo")

fs::dir_tree(path = "data")

# Seleção das variavies: 

vars_censo <- c("v0606","v0002", "v0601", "v0624", "v0010", "v0618", "v0619", "v0011")

# Converter o arquivo

sas_input <- SAScii::parse.SAScii(catalog$pes_sas) %>%
  dplyr::mutate(varname = stringr::str_to_lower(varname))

#Importando o arquivo


raw_censo <- readr::read_fwf(
  file = catalog$pes_file,
  col_positions = readr::fwf_widths(
    widths = abs(sas_input$width),
    col_names = sas_input$varname
  ),
  col_types = paste0(
    ifelse(
      !(sas_input$varname %in% vars_censo),
      "_",
      ifelse(sas_input$char, "c", "d")
    ),
    collapse = ""))


