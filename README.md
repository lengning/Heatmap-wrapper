# Heatmap-wrapper

Codes to generate heatmap, along with a example data set.
Example to run the code (from command line):

Rscript HC.R PCA_example.csv T T T 5 T F Out.pdf

or

Rscript HC.R PCA_example.csv T T T 5 T F

or

Rscript HC.R PCA_example.csv T T T 5 T F Out.pdf NULL NULL F

or

Rscript HC.R PCA_example.csv T T T 5 T F Out.pdf NULL NULL F 3 10 15 8 

or (To see heatmap by WaveCrestENI recovered cell order)

Rscript HC.R WC_example.csv T F T 5 T T Out.pdf NULL NULL

or (To see heatmap by WaveCrestENI recovered cell order)

Rscript HC.R WC_example.csv T F T 5 T T Out.pdf GeneList.csv Condition.csv
Rscript HC.R WC_example.txt T F T 5 T T Out.pdf GeneList.txt Condition.txt

or (To see heatmap by WaveCrestENI recovered cell order)

Rscript HC.R WC_example.csv T F T 5 T T Out.pdf GeneList.csv Condition.csv T 3 10 15 8
Rscript HC.R WC_example.txt T F T 5 T T Out.pdf GeneList.txt Condition.txt T 3 10 15 8

The inputs for the code are:

-  [FileNameIn] can take .csv, .txt or .tab
  
-  [Whether cluster by rows T/F] 
  
-  [Whether cluster by columns T/F] 
  
-  [Whether scale data within a row T/F] 
  
-  [Lower limit of detection] Genes with max expression below this threshold will be removed.
  
-  [Need normalization or not] If T is specified, median-by-ratio normalization will be performed prior to PCA analysis
  
-  [Whether run WaveCrest or not (RunWaveCrest)] If T is specified, WaveCrestENI will be performed prior and will plot heatmap by WaveCrestENI recovered cell order. If F is specified, regular heatmap will be provided, and both Condition.csv and markerList.csv files will be ignored

-  [OutputName] Need to be XX.pdf. The pdf width and height will be automatically adjusted based on # genes and # samples

-  [FileNameIn] can take .csv, .txt or .tab for WaveCrestENI (list of key markers) .  If NULL and RunWaveCrest =T ,all genes will be used for WaveCrestENI.
  
-  [FileNameIn] can take .csv, .txt or .tab for WaveCrestENI (condition of cells). If NULL and RunWaveCrest=T,. all cells will be considered as single condition.

-  [X11 activation] Default is T. If it is specified as F, X11 will be disactived

-  [bottom margin] [right margin] Two numbers to define margin width. Default is 7 for both parameters.
  
-  [pdf height] [pdf width] Two numbers to define pdf height and width. Default height is #rows/5; default width is #column/4.



If the last input is specified, the heatmap will be output as a pdf file.
Otherwise it will be shown in console.
green-red color scheme is used.

