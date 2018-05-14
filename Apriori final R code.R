

#reading excel

require(readxl)

file.names <- list.files(pattern=".xls")
for(i in 1:length(file.names)){
  
  
  xls1 <- read_excel(file.names[i],col_names=F,skip=17)
  
  if(i==1){
    #for reading colnames
    ColNameList <- read_excel(file.names[i],col_names=F,skip=15)
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

summary(stp2)

stp1$Customer <- as.factor(stp1$Customer)
stp1$StoreCode <- as.factor(stp1$StoreCode)
stp1$StoreDescription <- as.factor(stp1$StoreDescription)
stp1$HomeStoreCode <- as.factor(stp1$HomeStoreCode)
stp1$HomeStore <- as.factor(stp1$HomeStore)
stp1$Article <- as.factor(stp1$Article)
stp1$ArticleCode <- as.factor(stp1$ArticleCode)
stp2$CLPSalesMining <- as.numeric(stp2$CLPSalesMining)
stp1$CLPUnitsMining <- as.factor(stp1$CLPUnitsMining)
stp1$InvoiceNo <- as.factor(stp1$InvoiceNo)
stp1$Date <- as.factor(stp1$Date)

str(stp1)
stp2 <- stp1


# BASKET ANALYSIS AND PLOTTING



#group all the items that were bought together; by the same customer on the same date
library(plyr)

itmlst <- ddply(stp2, c("InvoiceNo"), function(df1)paste(df1$Article,collapse = ","))

head(itmlst, 1)

colnames(itmlst) <- sapply(colnames(itmlst),function(x)(gsub("\n","", x, fixed = TRUE)))

colnames(itmlst)

#remove member number and date

colnames(itmlst) <- c("InvoiceNo","items")

#write to csv format
write.csv(itmlst,"ItemList.csv", quote = FALSE, row.names = TRUE)

#load package required
library(arules)
library(arulesViz)


#convert csv file to basket format
txn <- read.transactions(file="ItemList.csv", rm.duplicates= FALSE, format="basket",sep=",",cols=1);

data(Adult)

summary(Adult)
tail(txn@itemInfo$labels, 10)

Other_oils <- txn[txn@itemInfo$labels %in% "OIL"]

itemFrequencyPlot(Other_oils[1:10,])


#binary incidence matrix

stp2 <- as.data.frame(stp1)
str(stp2)

bkt <- as(stp2, "transactions")
bkt  
Adult <- as(AdultUCI, "transactions")
Adult

summary(Adult)
summary(bkt)
dim(Adult)



#run apriori algorithm
system.time(txn_rules5 <- apriori(txn,parameter = list(minlen=2,support = 0.000632, confidence = 0.01, target="rules")))
#basket_rules <- apriori(txn,parameter = list(minlen=2,sup = 0.00001, conf = 0.01, target="rules"),appearance = list(lhs = "CLEMENTINES")))

system.time(bkt_rules <- apriori(bkt, parameter = list(minlen=2,support = 0.01, confidence = 0.6)))

summary(txn_rules7)


#summary(transactionInfo(txn[size(txn) > 50]))

inspect(txn_rules7[1:3])

#as(txn_rules2[1:3], "list")

itemFrequencyPlot(txn, topN = 50, cex = 0.7)
image(txn)

#view rules
inspect(rules_by_lift6[1:3])

rules_by_lift6 <- sort(txn_rules6, by = "lift")
inspect(head(unique(othoil.subR), 10))

## select the first 100 transactions for the items containing
#txn[1:10, c("OLV & FLXSD")]



## Select a subset of rules using partial matching on the items
## in the right-hand-side and a quality measure
rules.sub6 <- subset(txn_rules6, subset = rhs %pin% "OLV & FLXSD")

inspect(head(rules.sub6, n = 10, by = "support"))

#rules.sub2 <- subset(txn_rules3, subset = rhs %pin% "OLV & FLXSD")

inspect(head(rules.sub6, n = 10, by = "lift"))

othoil.subR6 <- subset(txn_rules6, subset = rhs %pin% "OIL")
othoil.subL6 <- subset(txn_rules6, subset = lhs %pin% "OIL")


inspect(head(othoil.subL6, n = 10, by = "lift"))
summary(othoil.subR6)
summary(othoil.subL6)



#convert to datframe and view; optional
df_oilR <- as(othoil.subR6,"data.frame")
df_oil$confidence <- df_oil$confidence * 100
df_oil$support <- df_oil$support * nrow(df)
head(df_oilR, 4)

summary(df_oilR)

df_oilR <- DATAFRAME(othoil.subR6, separate = TRUE, setStart = '', itemSep = ' + ', setEnd = '')

write.csv(df_oil,"Saf_oils.csv",row.names = FALSE)

inspect(df_oilRHS[10], ruleSep = "---->", itemSep = " + ", setStart = "", setEnd ="",
        linebreak = FALSE) ##good


plot(df_oilR$RHS, 


#plot the rules
library(arulesViz)
plot(txn_rules2)

set.seed(8000)

rules.sub3 <- sort(rules.sub3, by="lift")

plot(othoil.subL, method = "grouped", control=list(k=15))

plot(rules.sub, method = "grouped", control = list(k = 5))

#best
plot(rules.sub6, method="grouped",
     control = list(k = 40, col = grey.colors(10),
                    gp_labels= gpar(col = "blue", cex=0.9, fontface="italic")))


plot(rules.sub3[1:10,], method="graph", control=list(type="items"))

#best
#rules.sub6 <- head(sort(rules, by="lift"), 10)

plot(head(sort(rules.sub6, by="lift"), 25), method="graph",
     control = list(nodeCol = grey.colors(10), edgeCol = grey(.9), alpha = 1, cex = 0.7))

plot(rules.sub3[1:10,], method="paracoord",  control=list(alpha=.5, reorder=TRUE))


#itemFrequencyPlot(txn, topN = 5)

#plot(txn_rules[1:10,],measure=c("support","lift"),shading="confidence",interactive=T)

data("Adult")
itemFrequency(txn, type = "relative")




txnTidLists <- as(txn, "tidLists")

txnTidLists
#6859 items/itemsets (rows) and
#788 transactions (columns)

as(txnTidLists[1:10], "list")






itemFrequencyPlot(txn, support = 0.02, cex.names=0.8)

basket_rules #apriori variable

summary(basket_rules)

summary(txn)

str(txn)

#rulesIncomeSmall <- subset(basket_rules, subset = rhs %in% "income=small" & 
#                             lift > 7.3)

str(xls3)

inspect(head(txn, n = 3, by = "lift"))

inspect(head(txn, n = 3, by = "confidence"))

TXsets <- eclat(stp2, parameter = list(support = 0.05, maxlen = 10), control = list(verbose = FALSE))
#rules.TXsets <- ruleInduction(TXsets, stp2, confidence = 0.9)


summary(TXsets)
str(TXsets)

TXsingleItems <- TXsets[size(items(TXsets)) == 1]

summary(TXsingleItems)
## Get the col numbers we have support for
inspect(TXsingleItems[1:6,])

TXsingleSupport <- quality(TXsingleItems)$support
names(TXsingleSupport) <- unlist(LIST(items(TXsingleItems), decode = FALSE))



TXitemsetList <- LIST(items(TXsets), decode = FALSE)

head(itemsetList[1:3])

TXallConfidence <- quality(TXsets)$support / 
  sapply(TXitemsetList, function(x) max(TXsingleSupport[as.character(x)]))


quality(TXsets) <- cbind(quality(TXsets), TXallConfidence)

head(quality(fsets),5)

str(fsets)

TXsetsArticle <- subset(TXsets, subset = items %pin% "Article")

inspect(TXsetsArticle)

inspect(sort(fsetsEducation[size(fsetsEducation) > 1], 
             by = "allConfidence")[1:3])


#Transaction Amounts
#transaction amount histogram

hist(f4$CLPSalesMining, main = "Spend Per Basket", 
     xlab = "Amount in Rs.", breaks = 500, xlim = c(0,12000), freq = T)

boxplot(f3$CLPSalesMining, log = "y",  col = "bisque")

plot(f3$CLPSalesMining, type = "h", main = "Transaction Amounts", xlab = "Amount in Rs.")

summary(stp2$CLPSalesMining)


#frequency of visit

library(ggplot2)
library(dplyr)
library(zoo)



which(is.na(frequency3$Date))
frequency3[c(5477, 5478),]
frequency4 <- frequency3[-c(5477, 5478),]


summary(frequency4)
dim(frequency3)

library(lubridate)
class(frequency2$Date)
frequency2$Date <- mdy(frequency2$Date)
with(stp3, max(stp3$Date) - min(stp3$Date))
range(stp3$Date, na.rm = T)


plot(freq1 ~ Date, data = frequency4, type = "h", ylab = "frequency of visit")

#manipulating

x1 <- ddply(stp2, "Customer", each(nrow), na.rm = T)
summary(x1)

str(stp3)
stp3 <- stp2[,c(1,6,7,10,11)]
stp3$Date <- mdy(stp3$Date)
stp3$CLPSalesMining <- as.numeric(stp3$CLPSalesMining)
stp3$CLPUnitsMining <- as.numeric(stp3$CLPUnitsMining)
class(stp2)

str(stp3)

x5 <- stp3 %>% 
  group_by(InvoiceNo) %>% 
  summarize(Freq = n_distinct(InvoiceNo)) %>%
  arrange(desc(Freq))

head(x5)
tail(x5)
dim(x5)
str(x6)
summary(x5)
which(is.na(x5))
x5 <- x5[-c(4753),]

#plotting step x

x6 <- aggregate(Invoice ~ Date, data = x5, length)
summary(x6)
plot(x = x2$Date, y = x2$InvoiceNo, data = x2, type = "h")
hist(x2$InvoiceNo, freq = T)
class(x2$Month_Yr)

colnames(x2) <- c("Date", "Frequency", "MM-YY")

#best plot
require(ggplot2)
ggplot( data = x6, aes(Date, Invoice)) + 
  geom_line() + 
  scale_x_date(date_breaks = "2 months") +
  ylab("Frequency of Visits") +
  theme(panel.background = element_blank())
#geom_label(color = "black", fontface = "bold", size = 10) +
#geom_text(size = 10)



#
#theme_classic()

require(lubridate)

x2$Month_Yr <- format(x2$Date, "%Y-%m")


x7 <- stp3 %>%
  group_by(Customer) %>%
  summarize(SPC = mean(CLPSalesMining), UPC = mean(CLPUnitsMining))

summary(x7)

hist(x7$SPC, main = "Spend Per Customer", xlab = "Amount in Rs.", 
     ylab = "No. of Customers")



