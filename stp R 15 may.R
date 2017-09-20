

require(readxl)

file.names <- list.files(pattern=".xls")
for(i in 1:length(file.names)){
  
  
  xls1 <- read_excel(file.names[i],col_names=F,skip=17)
  
  if(i==1){
    #for reading colnames
    ColNameList <- read_excel(file.names[1],col_names=F,skip=15)
    xlsAll<-xls1
    xlsAll$X16 <- as.numeric(xlsAll$X16)
  }
  else{
    xlsAll <- rbind(xlsAll, xls1)
  }
  xlsAll
}
colnames(xlsAll)<-unlist(ColNameList[1,])

xlsAll2 <- xlsAll

str(xlsAll)

rm(ColNameList, i, file.names)

xls1 <- xlsAll

colnames(xls1)

#formating columns

colnames(xls1) <- sapply(colnames(xls1),function(x)(gsub("\n","", x, fixed = TRUE)))
colnames(xls1) <- sapply(colnames(xls1),function(x)(gsub(" ","", x, fixed = TRUE)))

stp1 <- xls1[,-c(2:5,10)]
str(stp1)

summary(stp1)

stp1$Customer <- as.factor(stp1$Customer)
stp1$StoreCode <- as.factor(stp1$StoreCode)
stp1$StoreDescription <- as.factor(stp1$StoreDescription)
stp1$HomeStoreCode <- as.factor(stp1$HomeStoreCode)
stp1$HomeStore <- as.factor(stp1$HomeStore)
stp1$Article <- as.factor(stp1$Article)
stp1$ArticleCode <- as.factor(stp1$ArticleCode)
stp1$CLPSalesMining <- as.numeric(stp1$CLPSalesMining)
stp1$CLPUnitsMining <- as.numeric(stp1$CLPUnitsMining)
stp1$InvoiceNo <- as.factor(stp1$InvoiceNo)
stp1$Date <- as.factor(stp1$Date)

str(stp1)
stp2 <- stp1


str(stp3)

summary(xlsAll)


f2 <- group_by(stp3, Customer)

f2 <- na.omit(f1)

f1[22212,]

summary(f2)

plot(f2)

which(is.na(f1$Customer))

summary(stp2)

stp4 <- na.omit(stp3)

#other oils frequency ***************

f2 <- group_by(df_oilR, RHS) %>%
  summarise(count = n())


# Create a rank variable based on importance
# Use ggplot2 to visualize the relative importance of variables
require(ggplot2)
require(ggthemes)

head(arrange(f5,  desc(count)), 25)%>%
  mutate(Rank = paste0('#',dense_rank(desc(count)))) %>%
  ggplot(aes(x = reorder(RHS, count), 
             y = count)) +
  geom_bar(stat='identity', colour = 'black') +
  geom_text(aes(x = RHS, y = 0.5, label = Rank),
            hjust=0, vjust=0.55, size = 4, colour = 'lavender',
            fontface = 'bold') +
  labs(x = 'Oils', title = 'Oils Shopped by Saffola Customers') +
  coord_flip() + 
  theme_few()

f5 <- subset(f2, !f2$RHS %in% c("KITCHENMATE ALUMINIUM FOIL 3*9MTR OP",
                                "HARPIC TOILET CLNR POWER PLUS ORIGINL 1L",
                                "HARPIC TOILT CLNR POWER 500M"))

str(f2)
f5$RHS <- as.factor(f5$RHS)

#subset(DF,  ! sub %in% c("1", "2", "3") )


head(f3,3)
#aggregate(stp4, InvoiceNo, mean)

summary(f3)


#checking if the sales and units are correct

subset(f3, f3$InvoiceNo == "2506-2034-64402-20170422")



#worked, items by invoice
f4 <- aggregate(cbind(CLPUnitsMining, CLPSalesMining) ~ InvoiceNo, data = stp3, sum)

#worked, items by customers
f3 <- aggregate(cbind(CLPUnitsMining, CLPSalesMining) ~ Customer, data = stp3, sum)

summary(f3)

summary(txn)

subset(f3, f3$CLPSalesMining >= 1124099)
 










