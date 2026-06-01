tall.packages("leaflet")
library(leaflet)

coverage <- data.frame(
  name=c("외대","경향신문","헌재","서부지법"),
  lat=c(37.5977, 37.5663, 37.5796, 37.5495), #위도
  lng=c(127.0606, 126.9705, 126.9849, 126.9546), #경도
  popup=c("25.02.28<br><b>외대 앞 탄반집회️</b></a>",
          "25.03.26<br><b>지혜복교사 간담회</b></a>",
          "25.04.02<br><b>탄핵 선고 전 극우집회</b></a>",
          "25.04.16<br><b>정윤석감독 탄원서</b></a>"),
  label=c("한국외국어대학교 서울캠퍼스","경향신문사","헌법재판소","서울서부지방법원")
)

leaflet(coverage) %>%
  addTiles() %>%  
  addMarkers(
    lng= ~lng, lat= ~lat, #지도 마커
    popup= ~popup,
    label= ~label
  )

title_html <- tags$div(
  style = "
    position: absolute;
    top: -10px;
    left:500%;
    transform: translateX(-50%);
    font-size: 15px;
    font-weight: bold;
    color: #2c3e50;
    background-color: rgba(255, 255, 255, 0.8);
    padding: 10px 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    z-index: 1000;
    white-space: nowrap;
  "
)

leaflet(coverage) %>%
  addTiles() %>%  
  addMarkers(
    lng= ~lng, lat= ~lat, #지도 마커
    popup= ~popup,
    label= ~label
  )%>%
  addControl(title_html)