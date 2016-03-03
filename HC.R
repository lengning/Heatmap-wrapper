# Input:
# [FileNameIn] [Whether cluster by rows T/F] [Whether cluster by columns T/F] [Whether scale data within a row T/F] 
# [Lower limit of detection] [Need normalization or not] [Plot columns by WaveCrestENI order or not] 
# [FileNameIn: list for key markers for WaveCrestENI] [FileNameIn: cell condition for WaveCrestENI] [whether active X11]
# [OutputName] [bottom margin] [right margin]
# [pdf height] [pdf width]

library(gplots)
options=commandArgs(trailingOnly = TRUE)
print(options)
File=options[1] # file name
Rowhc=as.logical(options[2])
Colhc=as.logical(options[3])
Scale=as.logical(options[4])
LOD=as.numeric(options[5]) # lower limit of detection
Norm=as.logical(options[6]) # whether perform normalization; if "T" is specified, median-by-ratio normalization will be performed.

RunWaveCrest=as.logical(options[7])
Out=options[8]
WCGeneList = options[9]
WCCond = options[10]
Plot=options[11] # whether plot
Margin1=as.numeric(options[12]) # margin - bottom
Margin2=as.numeric(options[13]) # margin - right
Height=as.numeric(options[14]) # pdf height
Width=as.numeric(options[15]) # pdf width

if(length(options) >9){ 
if(WCGeneList=="NULL") {WCGeneList=NULL}
if(WCCond=="NULL") {WCCond=NULL}
}
if(length(options)<8) {Out=WCGeneList=WCCond=NULL}
if(length(options)<9) {WCGeneList=WCCond=NULL}
if(length(options)<11) Plot="T"
if(length(options)<12) Margin1=7
if(length(options)<13) Margin2=7
if(length(options)<14) Height=NULL
if(length(options)<15) Width=NULL

if(RunWaveCrest) Colhc=FALSE	
if(!RunWaveCrest) {WCGeneList=WCCond=NULL}

if(Plot=="T") X11()

# csv or txt
tmp=strsplit(File, split="\\.")[[1]]
FileType=tmp[length(tmp)]

if(FileType=="csv"){
	cat("\n Read in csv file \n")
	prefix=strsplit(File,split="\\.csv")[[1]][1]
	In=read.csv(File,stringsAsFactors=F,row.names=1)
}
if(FileType!="csv"){
	cat("\n Read in tab delimited file \n")
	prefix=strsplit(File,split=paste0("\\.",FileType))[[1]][1]
	In=read.table(File,stringsAsFactors=F, sep="\t",header=T,row.names=1,quote="\"")
}

Matraw=data.matrix(In)

Max=apply(Matraw,1,max)
WhichRM=which(Max<LOD)
print(paste(length(WhichRM),"genes with max expression < ", LOD, "are removed"))

Mat=Matraw
if(length(WhichRM)>0)Mat=Matraw[-WhichRM,]
print(str(Mat))


if(Norm){
cat("\n ==== Performing normalization ==== \n")
library(EBSeq)
Sizes=MedianNorm(Mat)
if(is.na(Sizes[1]))cat("\n Warning: all genes have 0(s), normalization is not performed \n")
else Mat=GetNormalizedMat(Mat, MedianNorm(Mat))
}

# csv or txt
if(RunWaveCrest & is.null(WCGeneList) & is.null(WCCond)){
  GeneL = rownames(Mat)
  Cond = rep(1,dim(Mat)[2])
}

if(RunWaveCrest & !is.null(WCGeneList) & !is.null(WCCond)){

	tmp1=strsplit(WCGeneList, split="\\.")[[1]]
	FileType1=tmp1[length(tmp1)]
	tmp2=strsplit(WCCond, split="\\.")[[1]]
	FileType2=tmp2[length(tmp2)]

	if(FileType1=="csv"&FileType2=="csv"){
		cat("\n Read in csv file \n")
		prefix=strsplit(WCGeneList,split="\\.csv")[[1]][1]
		GeneList=read.csv(WCGeneList,stringsAsFactors=F)[[1]]
                if(length( which(!GeneList %in% rownames(Mat)))>0 ){print("Warning: not all provided markers are in data matrix")} 
                GeneL = GeneList[which(GeneList %in% rownames(Mat))]
		prefix=strsplit(WCCond,split="\\.csv")[[1]][1]
		Cond=read.csv(WCCond,stringsAsFactors=F)[[1]]
	}
	if(FileType1!="csv"&FileType2!="csv"){
		cat("\n Read in tab delimited file \n")
		prefix=strsplit(WCGeneList,split=paste0("\\.",FileType1))[[1]][1]
		GeneList=read.table(WCGeneList,stringsAsFactors=F, sep="\t",header=T,quote="\"")[[1]]
                if(length( which(!GeneList %in% rownames(Mat)))>0 ){print("Warning: not all provided markers are in data matrix")} 
                GeneL = GeneList[which(GeneList %in% rownames(Mat))]
		prefix=strsplit(WCCond,split=paste0("\\.",FileType2))[[1]][1]
		Cond=read.table(WCCond,stringsAsFactors=F, sep="\t",header=T,quote="\"")[[1]]
	}	
if(length(Cond) != dim(Mat)[2]) {"Stop: number of cells are not matching to Condition file"}
}


if(RunWaveCrest) {GeneL = as.factor(GeneL);condition = as.factor(Cond);print(str(GeneL));print(str(condition))}

sc="none"
if(Scale)sc="row"

Nrow=nrow(Mat)
Ncol=ncol(Mat)
if(is.null(Height)) Height=max(Nrow/5,4)+Margin1-7
if(is.null(Width)) Width=max(Ncol/4,4)+Margin2-7
if(RunWaveCrest){
	library(WaveCrest)
	Colhc=FALSE
	ENIRes = WaveCrestENI(GeneL,Mat,condition)
	Mat = Mat[,ENIRes]
} 

if(!is.null(Out))pdf(Out,width=Width,height=Height)
if(Plot=="T" | (!is.null(Out)))tmp=heatmap.2(Mat,trace="none",Rowv=Rowhc,
			Colv=Colhc,scale=sc,keysize=max(4/Nrow,.5),
				col=greenred,margins=c(Margin1,Margin2))
if(!is.null(Out))dev.off()

if(is.null(Out) & Plot=="T")Sys.sleep(1e30)

