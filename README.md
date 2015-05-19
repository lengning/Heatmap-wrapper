# Heatmap-wrapper

Codes to generate heatmap, along with a example data set.
Example to run the code (from command line):

Rscript HC.R PCA_example.csv T T T 5 T HCout.pdf

or

Rscript HC.R PCA_example.csv T T T 5 T

or

Rscript HC.R PCA_example.csv T T T 5 T HCout.pdf 3 10 15 8

The inputs for the code are:

-  [FileNameIn] can take .csv, .txt or .tab
  
-  [Whether cluster by rows T/F] 
  
-  [Whether cluster by columns T/F] 
  
-  [Whether scale data within a row T/F] 
  
-  [Lower limit of detection] Genes with max expression below this threshold will be removed.
  
-  [Need normalization or not] If T is specified, median-by-ratio normalization will be performed prior to PCA analysis
  
-  [OutputName] Need to be XX.pdf. The pdf width and height will be automatically adjusted based on # genes and # samples

-  [bottom margin] [right margin] Two numbers to define margin width. Default is 7 for both parameters.
  
-  [pdf height] [pdf width] Two numbers to define pdf height and width. Default height is #rows/5; default width is #column/4.

If the last input is specified, the heatmap will be output as a pdf file.
Otherwise it will be shown in console.
green-red color scheme is used.

