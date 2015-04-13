# Heatmap-wrapper

Codes to generate heatmap, along with a example data set.
Example to run the code (from command line):

Rscript HC.R PCA_example.csv T T T 5 T HCout.pdf

or

Rscript HC.R PCA_example.csv T T T 5 T

The inputs for the code are:

-  [FileNameIn] can take .csv, .txt or .tab
  
-  [Whether cluster by rows T/F] 
  
-  [Whether cluster by columns T/F] 
  
-  [Whether scale data within a row T/F] 
  
-  [Lower limit of detection] Genes with max expression below this threshold will be removed.
  
-  [Need normalization or not] If T is specified, median-by-ratio normalization will be performed prior to PCA analysis
  
-  [OutputName] Need to be XX.pdf. The pdf width and height will be automatically adjusted based on # genes and # samples

If the last input is specified, the heatmap will be output as a pdf file.
Otherwise it will be shown in console.
green-red color scheme is used.

