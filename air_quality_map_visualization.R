# 미세먼지 농도 시간대별 그래프

install.packages("XML")
install.packages("ggplot2")
library(XML)
library(ggplot2)

api <- "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst"
api_key <- "YOUR_API_KEY"
numOfRows <- 12
pageNo    <- 1
itemCode  <- "PM10"
dataGubun <- "HOUR"
searchCondition <- "MONTH"


url <- paste(api,  
             "?serviceKey=", api_key,
             "&numOfRows=", numOfRows,
             "&pageNo=", pageNo,
             "&itemCode=", itemCode,
             "&dataGubun=", dataGubun,
             "&searchCondition=", searchCondition,
             sep="") 
url

xmlFile <- xmlParse(url) 
xmlFile

df <- xmlToDataFrame(getNodeSet(xmlFile, "//items/item"))
df

ggplot(data=df, aes(x=dataTime, y=jeju))+
  geom_bar(stat="identity", fill="orange") +
  theme(axis.text.x=element_text(angle=90)) +
  labs(title="시간대별 서울지역의 미세먼지 농도 변화", x = "측정일시", y = "농도")



install.packages("ggplot2")
install.packages("XML")
library(ggplot2)
library(XML)

api <- "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst"

api_key <- "YOUR_API_KEY"

numOfRows <- 10
pageNo    <- 1
itemCode  <- "PM10"
dataGubun <- "HOUR"
searchCondition <- "MONTH"

url <- paste(api,
             "?serviceKey=", api_key,
             "&numOfRows=", numOfRows,
             "&pageNo=", pageNo,
             "&itemCode=", itemCode,
             "&dataGubun=", dataGubun,
             "&searchCondition=", searchCondition,
             sep="")
url             

xmlFile <- xmlParse(url)
xmlFile           

df <- xmlToDataFrame(getNodeSet(xmlFile, "//items/item"))
df

pm <- df[1, c(1:16, 19)]
pm

pm.region <- t(pm) 
pm.region


df.region <- as.data.frame(pm.region)
df.region

colnames(df.region) <- "PM10"

df.region$NAME <- c("대구광역시", "충청남도", "인천광역시", "대전광역시", "경상북도", 
                    "세종특별자치시", "광주광역시", "전라북도", "강원도", "울산광역시", 
                    "전라남도", "서울특별시", "부산광역시", "제주특별자치도", "충청북도", 
                    "경상남도", "경기도")
df.region

# 각 지역별 중심 위도경도 데이터 만들기 

korea_regions <- data.frame(
  NAME = c("서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", 
           "대전광역시", "울산광역시", "세종특별자치시", "경기도", "강원도", 
           "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", 
           "경상남도", "제주특별자치도"),
  lat = c(37.5665, 35.1796, 35.8714, 37.4563, 35.1595, 
          36.3504, 35.5393, 36.4804, 37.4138, 37.8228, 
          36.6357, 36.6588, 35.7175, 34.816, 36.5761, 
          35.1796, 33.4996),
  lng = c(126.9780, 129.0756, 128.6014, 126.7052, 126.8526, 
          127.3845, 129.3114, 127.2895, 127.5183, 128.1555, 
          127.4914, 126.7052, 127.153, 126.463, 128.5056, 
          128.051, 126.5312)
)

# 두 데이터 (미세먼지 정보 데이터와 지역별 위경도 정보 데이터) 합치기

install.packages("dplyr")
library(dplyr)
PM10_map <- full_join(df.region, korea_regions, by='NAME')


# 지도 데이터 준비하기 
install.packages("sf")
install.packages("sp")
library(sf)
library(sp)
map_tm <- st_read('YOUR_PATH/ctprvn.shp')

map_tm <- st_set_crs(map_tm, 5179)
map_wgs84 <- st_transform(map_tm, crs=4326)

map_korea <- map_wgs84
map_korea_shp <-  as(map_korea, 'Spatial')
map_korea_df <- fortify(map_korea_shp)


ggplot() +
  geom_polygon(data = map_korea_df, 
               aes(x = long, y = lat, group = group), 
               fill = "white", alpha=0.5, 
               color="black") +
  geom_point(data=PM10_map, 
             aes(x=lng, y=lat, size=PM10),
             shape=21, color='black', 
             fill='red', alpha=0.3) +
  theme(legend.position = "none") + 
  labs(title="미세먼지 농도", x="경도", y="위도")

