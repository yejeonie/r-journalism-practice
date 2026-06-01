# 뉴스 검색 및 데이터 정제

install.packages("RCurl")
install.packages("RmecabKo")
install.packages("XML")
install.packages("wordcloud2")

library(RCurl)
library(XML)
library(wordcloud2)
library(RmecabKo)

install_mecab("C:/RmecabKo/mecab")
library(RmecabKo)

searchUrl     <- "https://openapi.naver.com/v1/search/news.xml"
Client_ID     <- "YOUR_NAVER_CLIENT_ID"
Client_Secret <- "YOUR_NAVER_CLIENT_SECRET"

query <- URLencode(iconv("이준석","UTF-8"))     

url <- paste(searchUrl, "?query=", query, "&display=30", sep="") 

doc <- getURL(url, 
              httpheader = c('Content-Type' = "application/xml",
                             'X-Naver-Client-Id' = Client_ID,
                             'X-Naver-Client-Secret' = Client_Secret))
doc 

xmlFile <- xmlParse(doc) 
xmlFile

df <- xmlToDataFrame(getNodeSet(xmlFile, "//item")) 
str(df)

description <- df[,4] 
description

description2 <- gsub("\\d|<b>|</b>|후보|이준석", "", description)
description2 

nouns <- nouns(iconv(description2, "utf-8"))   
nouns

nouns.all <- unlist(nouns, use.names = F) 
nouns.all

nouns.all.2 <- nouns.all[nchar(nouns.all) >= 2]       
nouns.all.2  

nouns.freq <- table(nouns.all.2)
nouns.freq

nouns.df <- data.frame(nouns.freq)
nouns.df.sort <- nouns.df[order(-nouns.df$Freq), ] 
nouns.df.sort

wordcloud2(nouns.df.sort,
           size = 1,
           rotateRatio=0.5)

wordcloud2(nouns.df.sort,
           size = 0.3,
           shape = 'star')




searchUrl     <- "https://openapi.naver.com/v1/search/news.xml"
Client_ID     <- "YOUR_NAVER_CLIENT_ID"
Client_Secret <- "YOUR_NAVER_CLIENT_SECRET"


query <- URLencode(iconv("이재명","UTF-8"))

url <- paste(searchUrl, "?query=", query, "&display=100", sep="")

url <- paste(searchUrl, "?query=", query, "&display=100","&sort=sim", sep="")

doc <- getURL(url, 
              httpheader = c('Content-Type' = "application/xml",
                             'X-Naver-Client-Id' = Client_ID,
                             'X-Naver-Client-Secret' = Client_Secret))
doc

xmlFile <- xmlParse(doc)
xmlFile

df <- xmlToDataFrame(getNodeSet(xmlFile, "//item"))
str(df)

description <- df[,4]
description

description2 <- gsub("\\d|<b>|</b>", "", description)
description2



nouns <- nouns(iconv(description2, "utf-8"))
nouns

nouns.all <- unlist(nouns, use.names = F)
nouns.all

nouns.all.2 <- nouns.all[nchar(nouns.all) >= 2]
nouns.all.2  

nouns.freq <- table(nouns.all.2)
nouns.freq

nouns.df <- data.frame(nouns.freq)
nouns.df.sort <- nouns.df[order(-nouns.df$Freq), ] 
head(nouns.df.sort, n=10)


wordcloud2(nouns.df.sort,
           size = 1,
           rotateRatio=0.5)




doc <- getURL("https://news.daum.net/")
doc

daumhtml <- htmlParse(doc)
daumhtml

daumxml <- xmlParse(doc)  
daumxml


# 블로그에서 검색

searchUrl     <- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID     <- "YOUR_NAVER_CLIENT_ID"
Client_Secret <- "YOUR_NAVER_CLIENT_SECRET"


query <- URLencode(iconv("이준석","UTF-8"))

url <- paste(searchUrl, "?query=", query, "&display=50","&sort=sim", sep="")
url <- paste(searchUrl, "?query=", query, "&display=50","&sort=date", sep="")


doc <- getURL(url, 
              httpheader = c('Content-Type' = "application/xml",
                             'X-Naver-Client-Id' = Client_ID,
                             'X-Naver-Client-Secret' = Client_Secret))
doc

xmlFile <- xmlParse(doc)
xmlFile

df <- xmlToDataFrame(getNodeSet(xmlFile, "//item"))
str(df)

description <- df[,3] #
description

description2 <- gsub("\\d|<b>|</b>|대선|이준석", "", description)
description2

nouns <- nouns(iconv(description2, "utf-8"))
nouns

nouns.all <- unlist(nouns, use.names = F)
nouns.all

nouns.all.2 <- nouns.all[nchar(nouns.all) >= 2]
nouns.all.2  

nouns.freq <- table(nouns.all.2)
nouns.freq

nouns.df <- data.frame(nouns.freq)
nouns.df.sort <- nouns.df[order(-nouns.df$Freq), ] 
head(nouns.df.sort, n=30)


wordcloud2(nouns.df.sort,
           size = 1,
           rotateRatio=0.5)

