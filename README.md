# associations
using associations rule learning for market basket analysis

Association rule learning is a rule-based machine learning method for discovering interesting relations between variables in large databases. It is intended to identify strong rules discovered in databases using some measures of interestingness.

Based on the concept of strong rules, Rakesh Agrawal, Tomasz Imieliński and Arun Swami[2] introduced association rules for discovering regularities between products in large-scale transaction data recorded by point-of-sale (POS) systems in supermarkets. For example, the rule {\displaystyle \{\mathrm {onions,potatoes} \}\Rightarrow \{\mathrm {burger} \}} \{{\mathrm  {onions,potatoes}}\}\Rightarrow \{{\mathrm  {burger}}\} found in the sales data of a supermarket would indicate that if a customer buys onions and potatoes together, they are likely to also buy hamburger meat. Such information can be used as the basis for decisions about marketing activities such as, e.g., promotional pricing or product placements.

In addition to the above example from market basket analysis association rules are employed today in many application areas including Web usage mining, intrusion detection, continuous production, and bioinformatics. In contrast with sequence mining, association rule learning typically does not consider the order of items either within a transaction or across transactions.

Support
Support is an indication of how frequently the itemset appears in the dataset.

The support of {\displaystyle X} X with respect to {\displaystyle T} T is defined as the proportion of transactions {\displaystyle t} t in the dataset which contains the itemset {\displaystyle X} X.

Confidence
Confidence is an indication of how often the rule has been found to be true.

The confidence value of a rule, {\displaystyle X\Rightarrow Y} X\Rightarrow Y , with respect to a set of transactions {\displaystyle T} T, is the proportion of the transactions that contains {\displaystyle X} X which also contains {\displaystyle Y} Y.

The lift of a rule is defined as:

{\displaystyle \mathrm {lift} (X\Rightarrow Y)={\frac {\mathrm {supp} (X\cup Y)}{\mathrm {supp} (X)\times \mathrm {supp} (Y)}}} {\mathrm  {lift}}(X\Rightarrow Y)={\frac  {{\mathrm  {supp}}(X\cup Y)}{{\mathrm  {supp}}(X)\times {\mathrm  {supp}}(Y)}}

or the ratio of the observed support to that expected if X and Y were independent.

Wikipedia - https://en.wikipedia.org/wiki/Association_rule_learning
