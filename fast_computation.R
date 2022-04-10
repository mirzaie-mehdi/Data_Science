x<- c(3,7,8,-2,0.5,1.54)
print(x)
stname<-c("ali","hossein")
stname
ok <- c(TRUE,TRUE,FALSE)
length(ok)
pi
##Fast computations on large data frames and matrices
```{R Fast computation on DataFrame}

myDF <- as.data.frame(matrix(rnorm(100000), 10000, 10)) # Creates an example data frame.
myCol <- c(1,1,1,2,2,2,3,3,4,4);
myDFmean <- t(aggregate(t(myDF), by=list(myCol), FUN=mean, na.rm=T)[,-1])
colnames(myDFmean) <- tapply(names(myDF), myCol, paste, collapse="_"); myDFmean[1:4,]
# The aggregate function can be used to perform calculations (here mean) across rows for any combination of column selections (here myCol) after transposing the data frame.
# However, this will be very slow for data frames with millions of rows.
myList <- tapply(colnames(myDF), c(1,1,1,2,2,2,3,3,4,4), list)
names(myList) <- sapply(myList, paste, collapse="_"); 
myDFmean <- sapply(myList, function(x) mean(as.data.frame(t(myDF[,x])))); myDFmean[1:4,]              
# Faster alternative for performing the aggregate computation of the previous step. However, this step will be still very slow for very large data sets, 
# due to the sapply loop over the row elements.
myList <- tapply(colnames(myDF), c(1,1,1,2,2,2,3,3,4,4), list)
myDFmean <- sapply(myList, function(x) rowSums(myDF[,x])/length(x)); colnames(myDFmean) <- sapply(myList, paste, collapse="_")
myDFmean[1:4,]             
# By using the rowSums or rowMeans functions one can perform the above aggregate computations 100-1000 times faster by avoiding a loop over the rows altogether.
myDFsd <- sqrt((rowSums((myDF-rowMeans(myDF))^2)) / (length(myDF)-1)); myDFsd[1:4]
# Similarly, one can compute the standard deviation for large data frames by avoiding loops.
# This approach is about 100 times faster than the loop-based alternatives: sd(t(myDF)) or apply(myDF, 1, sd).


x <- matrix(rnorm(48), 12, 4, dimnames=list(month.name, paste("t", 1:4, sep=""))); corV <- cor(x["August",], t(x), method="pearson"); y <- cbind(x, correl=corV[1,]); y[order(-y[,5]), ] 
# Commands to perform a correlation search and ranking across all rows (matrix object required here). First, an example matrix 'x' is created.
# Second, the correlation values for the "August" row against all other rows are calculated. 
# Finally, the resulting vector with the correlation values is merged with the original matrix 'x' and sorted by decreasing correlation values.


# merge(frame1, frame2, by.x = "frame1col_name", by.y = "frame2col_name", all = TRUE) 
# Merges two data frames (tables) by common field entries. To obtain only the common rows, change 'all = TRUE' to 'all = FALSE'. 
# To merge on row names (indices), refer to it with "row.names" or '0', e.g.: 'by.x = "row.names", by.y = "row.names"'.
my_frame1 <- data.frame(title1=month.name[1:8], title2=1:8);
my_frame2 <- data.frame(title1=month.name[4:12], title2=4:12);
merge(my_frame1, my_frame2, by.x = "title1", by.y = "title1", all = TRUE) # Example for merging two data frames by common field.

```