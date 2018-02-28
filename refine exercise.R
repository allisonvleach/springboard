purchases <- read.csv(file.choose()) # prompts you to choose the file to be loaded 


summary(purchases)


install.packages("dplyr")

library(dplyr)

#1 Clean up the 'company' column so all of the misspellings of the brand names are standardized.

#philips, akzo, van houten and unilever (all lowercase).

purchases %>% select(company)

purchases$company

install.packages("grepl")

#match for strings that end with ps

grepl(pattern = "ps$", x = purchases$company)

#match for instances of strings that end with ps
grep(pattern = "ps$", x = purchases$company)

?sub

philips <- grep(pattern = "ps$", x = purchases$company)

#list of items to replace
purchases$company[philips]

"philips" <- purchases$company[philips]

philipscount <- purchases$company[philips]


purchases$company[philips]

#you did it! this is how you replaced a value by using subscripts
purchases$company[agrep("ps$", purchases$company)] <- "philips"

purchases$company[agrep("llips$", purchases$company)] <- "philips"


#now the list is correct (for philips)
purchases$company

#correcting for akzo
purchases$company[agrep("^ak", purchases$company)] <- "akzo"


purchases$company

#correcting for van houten
purchases$company[agrep("^van", purchases$company)] <- "van houten"

purchases$company

#correcting for unilever
purchases$company[agrep("^uni", purchases$company)] <- "unilever"

purchases$company

levels(purchases$company)

#change to lowercase
purchases$company <- tolower(purchases$company)

#final fixed company column :)
purchases$company








"philips" <- grep(pattern = "ps$", x = purchases$company)

purchases$company

"philips"

purchases$company[1, 2, 3, 4, 5, 14, 15, 16]

purchases$company[company %in% ]


purchases$Product.code...number



#2 Separate the product code and product number into separate columns i.e. add two new columns called product_code and product_number, 


install.packages("stringr")

#splitvalues
split <- strsplit(as.character(purchases$Product.code...number), '-')

split

splitafter <- t(sapply(split,'['))
splitafter

#adding these new columns to purchases
purchases <- cbind(splitafter, purchases)

purchases

purchases


#rename columns

colnames(purchases)[1] <- "product_code"

purchases$product_code

#this works
names(purchases)[1] <- "product_code"

purchases$product_code

purchases

#rename other column
names(purchases)[2] <- "product_number"

purchases


#make into columns

do.call(rbind, split)

purchases(purchases$Product.code...number, do.call(rbind, split)
          
purchases$Product.code...number

#3 Add a column with the product category for each record. p = Smartphone, v = TV, x = Laptop, q = Tablet

#new column
purchases$newcolumn <- NA

#copy data to new column
purchases$newcolumn<-purchases$product_code

ncol(purchases)

#rename new column

names(purchases)[9] <- "product_catagory"

purchases


#change product codes to product category names

levels(purchases$product_catagory)

levels(purchases$product_catagory)[match("p",levels(iris$Species))] <- "Smartphone"

purchases$product_catagory("p") <- purchases$product_catagory("Smartphone")

#increase factor levels first
levels(purchases$product_catagory) <- c(levels(purchases$product_catagory), "Smartphone")

#replace value
purchases$product_catagory[purchases$product_catagory == 'p'] <- 'Smartphone'

#repeat
levels(purchases$product_catagory) <- c(levels(purchases$product_catagory), "TV")
purchases$product_catagory[purchases$product_catagory == 'v'] <- 'TV'

levels(purchases$product_catagory) <- c(levels(purchases$product_catagory), "Laptop")
purchases$product_catagory[purchases$product_catagory == 'x'] <- 'Laptop'

levels(purchases$product_catagory) <- c(levels(purchases$product_catagory), "Tablet")
purchases$product_catagory[purchases$product_catagory == 'q'] <- 'Tablet'


#4 Add full address for geocoding -- Create a new column full_address that concatenates the three address fields (address, city, country), separated by commas.

#create cols
cols <- c("address", "city", "country")
purchases$full_address <- do.call(paste, c(purchases[cols], sep=","))
purchases


#5 Create dummy binary variables for each of them with the prefix company_ and product_ i.e., 

#Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever.

#sub-language to translate forumulas into design matrix
#copy company column
purchases$copied_company <-purchases$company

#create dummy matrix
dummy <- model.matrix(~ purchases$copied_company - 1, data = purchases)

#rename columns
colnames(dummy) <- c("company_akzo", "company_philips", "company_unilver", "company_van_houten")
dummy

#add columns to dataset
purchases <- cbind(dummy, purchases)
purchases

#Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet.

#create new dummy variables
newdummy <- model.matrix(~ purchases$product_catagory - 1, data = purchases)
newdummy <- newdummy[, -c(1:4)]
newdummy

ncol(newdummy)

#rename dummy columns
colnames(newdummy) <- c("product_smartphone", "product_tablet", "product_tv", "product_laptop")
newdummy

#add columns to dataset
purchases <- cbind(newdummy, purchases)
purchases 

ncol(purchases)

purchases <- purchases[, -18]

#completed dataset!
purchases

# Write CSV in R
write.csv(purchases, file = "refine_clean.csv")
