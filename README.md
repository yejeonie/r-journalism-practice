# R Journalism Practice

저널리즘과 데이터 분석을 연결하는 R 실습 코드 모음입니다.

## 파일 구성

### 1. `news_scraping_election_wordcloud.R`
네이버 뉴스 오픈API를 활용해 21대 대선 후보 관련 뉴스를 수집하고,
텍스트를 정제한 뒤 워드클라우드로 시각화했습니다.
- 사용 라이브러리: `rvest`, `RCurl`, `XML`, `RmecabKo`, `wordcloud2`
- 실습 내용: API 호출, 텍스트 정제(gsub), 형태소 분석, 시각화

### 2. `leaflet_coverage_map.R`
당시 주요 뉴스 현장으로 자주 등장한 취재처를 지도 위에 시각화했습니다. 
탄핵 찬반집회, 헌법재판소, 서울서부지방법원 등의 위경도 데이터를 직접 구성해 마커로 표시했습니다.
- 사용 라이브러리: `leaflet`
- 실습 내용: 위경도 데이터 구성, 인터랙티브 지도 시각화

### 3. `air_quality_map_visualization.R`
공공데이터포털 미세먼지 API에서 시도별 PM10 데이터를 수집하고,
한국 지도 위에 지역별 농도를 시각화했습니다.
- 사용 라이브러리: `XML`, `ggplot2`, `sf`, `dplyr`
- 실습 내용: 공공API 호출, 데이터 정제, shapefile 기반 지도 시각화

## 비고
API 키는 보안상 제거했습니다. 실행하려면 각 파일의 `YOUR_API_KEY` 부분에 본인 키를 입력하세요.
