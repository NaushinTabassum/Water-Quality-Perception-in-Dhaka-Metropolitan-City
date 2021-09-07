#reading the csv file
form <- read.csv("ResponsesRaw.csv", header=FALSE, na.strings = "")
#removing the timestamp column
form<- form[,-1]
# removing the parenthesis portion
for(i in 1:dim(form)[1]){
    for(j in 1:dim(form)[2]){
       if((j!=29 | j!= 30 | j!= 31)){
          form[i,j] <- strsplit(form[i,j], "(", fixed=TRUE)[1]
          form[i,j] <- trimws(form[i,j])
       }
       else if((j!=29 | j!= 30 | j!= 31) & i==1){
         form[i,j] <- strsplit(form[i,j], "(", fixed=TRUE)[1]
         form[i,j] <- trimws(form[i,j])
       }
    }
}

# removing " Taka" from the values and adding it to the variable name
form[1,33] <- paste(form[1,33],"(Taka)")
form[-1,33] <- gsub(" Taka","", form[-1,33])

# adding column names
names(form) <- form[1,]
# removing the names from the first row
form <- form[-1,]
# making the column names valid
names(form)<- make.names(names(form))

# Converting household and occupant numbers from character to numeric
for(i in 29:31){
    form[,i] <- as.numeric(form[,i])
}
#replacing the weird string with apostrophe comma
form[,32] <- gsub("â€™","'", form[,32])
#writing the data frame into another csv file
write.csv(form, "cleaned1.csv", row.names = FALSE)




