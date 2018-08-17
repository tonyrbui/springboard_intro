library(tibble)
library(tidyr)
library(dplyr)
library(readr)

options(dplyr.width = Inf)

ref_df <-
  as_tibble(read.csv(file = "refine_original.csv", header = TRUE, sep = ","))

# Standardizing companies
ref_df$company <- tolower(ref_df$company)

ref_df$company <- gsub(pattern = ".+ps$",
                       replacement = "philips",
                       x = ref_df$company)
ref_df$company <- gsub(pattern = "^ak.+",
                       replacement = "akzo",
                       x = ref_df$company)
ref_df$company <- gsub(pattern = "^van\\shouten.+",
                       replacement = "van houten",
                       x = ref_df$company)
ref_df$company <- gsub(pattern = "^unil.+",
                       replacement = "unilever",
                       x = ref_df$company)

# Separating product_code and product_number for "tidy" variable columns
ref_df <- ref_df %>%
  separate(col = "Product.code...number",
           into = c("product_code",
                    "product_number"))

# Creating product_category data frame to map to product_code
cat_df <- tibble(
  product_code = c("p", "v", "x", "q"),
  product_category = c("Smartphone", "TV", "Laptop", "Tablet")
)

# Adding product_category to represent product_code to be more readable
ref_df <- inner_join(ref_df, cat_df)

# Adding full_address for geocoding
ref_df <- ref_df %>%
  mutate(full_address = paste(address, city, country, sep = ","))

# Adding categorical company variables
ref_df <- ref_df %>%
  mutate(dummy_company = company, dummy_val = 1) %>%
  spread(key = dummy_company, value = dummy_val, fill = 0)

ref_df <- ref_df %>%
  rename(
    company_akzo = akzo,
    company_philips = philips,
    company_unilever = unilever,
    company_van_houten = `van houten`
  )

# Adding categorical product variables
ref_df <- ref_df %>%
  mutate(dummy_product = product_category, dummy_val = 1) %>%
  spread(key = dummy_product, value = dummy_val, fill = 0)

ref_df <- ref_df %>%
  rename(
    product_smartphone = Smartphone,
    product_tablet = Tablet,
    product_tv = TV,
    product_laptop = Laptop
  )

# Creating refine_clean.csv
write_csv(x = ref_df, path = "refine_clean.csv")
