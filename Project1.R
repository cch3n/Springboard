library(dplyr)
library(tidyr)
toy <- refine_original
toy$company <- tolower(toy$company)
toy$company <- sub(pattern = "^ak.*", replacement = "akzo", x = toy$company)
toy$company <- sub(pattern = ".*\\ps", replacement = "phillips", x = toy$company)
toy$company <- sub(pattern = "^uni.*", replacement = "unilever", x = toy$company)
toy <- separate(toy, `Product code / number`, c( "product_code", "product_number"), sep = "-" )

toy$product_name <- sub(pattern = "^p.*", replacement = "Smartphone", sub(pattern = "^v.*", replacement = "TV", 
                                                                          sub(pattern = "^.*x", replacement = "Laptop", 
                                                                              sub(pattern = "^q.*", replacement = "Tablet", x = toy$product_code))))
toy <- unite(toy, full_address, address, city, country, sep = ", ")
toy <- mutate(toy, company_phillips = ifelse(company == "phillips", 1,0))
toy <- mutate(toy, company_akzo = ifelse(company == "akzo", 1,0))
toy <- mutate(toy, company_van_houten = ifelse(company == "van houten", 1,0))
toy <- mutate(toy, company_unilever = ifelse(company == "unilever", 1,0))
toy <- mutate(toy, product_smartphone = ifelse(product_code == "p", 1,0))
toy <- mutate(toy, product_laptop = ifelse(product_code == "x", 1,0))
toy <- mutate(toy, product_tv = ifelse(product_code == "v", 1,0))
toy <- mutate(toy, product_tablet = ifelse(product_code == "q", 1,0))

write.csv(toy, file = "refine_clean.csv")
read.csv("refine_clean.csv")