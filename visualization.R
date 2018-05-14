
require(arulesViz)

install.packages("seriation")

install.packages("Rgraphviz")

data("Groceries")
summary(Groceries)

#mine association rules using the Apriori algorithm implemented in arules.

rules <- apriori(Groceries, parameter = list(support = 0.001, confidence = 0.5))

rules
#5668 association rules.


#The top three rules with respect to the lift measure, a popular measure of rule strength, are:
inspect(head(sort(rules, by = "lift"), 3))

#
#plot(x, method = NULL, measure = "support", shading = "lift",
# interactive = FALSE, data = NULL, control = NULL, ...)

plot(rules) 

#The default method for plot() for association rules in arulesViz is a scatter plot using support
#and confidence on the axes. In addition a third measure (default: lift) is used as the color
#(gray level) of the points. A color key is provided to the right of the plot.


head(quality(rules))

plot(rules, measure = c("support", "lift"), shading = "confidence")



?interestMeasure

#Here support and confidence are used for the x and y-axes and the color of the
#points is used to indicate "order," i.e., the number of items contained 
#in the rule.

plot(rules, shading = "order", control = list(main = "Two-keyplot"))

#order and support have a very strong inverse relationship, which is a 
#known fact for association rules

sel <- plot(rules, measure = c("support", "lift"), shading = "confidence",
            interactive = TRUE) #heavy, freezes the system

subrules <- rules[quality(rules)$confidence > 0.8]

subrules

plot(subrules, method = "matrix", measure = "lift")

#reordering columns and rows

plot(subrules, method = "matrix", measure = "lift", 
     control = list(reorder = TRUE))


#using 3D plot

plot(subrules, method="matrix3D", measure="lift")

plot(subrules, method="matrix3D", measure="lift", control=list(reorder=TRUE))


#If we specify a vector with two measures, both measures are used simultaneously using color
#hue for one measure and luminance and chroma together for the other.

plot(subrules, method="matrix", measure=c("lift", "confidence"))

plot(subrules, method="matrix", measure=c("lift", "confidence"), control=list(reorder=TRUE))

#High confidence/high support rules can be identified in the plot as hot/red
#(high confidence) and dark/intense (high support).


#GROUPED MATRIX
plot(rules, method = "grouped")

#increasing number of k
plot(rules, method = "grouped", control= list(k = 50))

#interactive #heavy
sel <- plot(rules, method = "grouped", interactive = TRUE)

#graph based visualization
subrules2 <- head(sort(rules, by = "lift"), 10)


#The following plot represents items and rules as vertices connecting
#them with directed edges
plot(subrules2, method = "graph")

#vertices typically represent items or itemsets
#and edges indicate relationship in rules.

plot(subrules2, method = "graph", control = list(type = "itemsets"))

#This representation focuses on how the rules are composed
#of individual items and shows which rules share items.

saveAsGraph(head(sort(rules, by = "lift"), 1000), file = "rules.graphml")

#PARALLEL COORDINATES PLOT

plot(subrules2, method = "paracoord")

#The width of the arrows represents support and the 
#intensity of the color represent confidence.

plot(subrules2, method = "paracoord", control = list(reorder = TRUE))

#double decker plot

#A double decker plot is a variant of a mosaic plot.

oneRule <- sample(rules, 1)

inspect(oneRule)

plot(oneRule, method = "doubledecker", data = Groceries)

#The area of blocks gives the support and the height of
#the "yes" blocks is proportional to the confidence for the rules consisting of the antecedent
#items marked as "yes."

#difference of confidence











