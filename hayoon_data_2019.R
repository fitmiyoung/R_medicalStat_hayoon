install.packages('readxl')
install.packages('ggplot2')
install.packages('tidyverse')
library(readxl)
library(ggplot2)
library(tidyverse)
getwd()
hayoon<-read_excel("hayoon_hist.xlsx")
str(hayoon)

ggplot(hayoon, aes(x=date, y=medic))+geom_point()

sep<-seperate(data=hayoon, col = disease, sep=", ", into = ("d1", "d2"))
sep

#질병명 카테고리로 만들기
dis_f<-as.factor(hayoon$disease)
hayoon$disease <- dis_f
class(hayoon$disease)
hayoon %>%
  group_by(hayoon$disease) %>%
  summarise(n=n())

#단순 통계 
names(hayoon) #칼럼명만 보기 
dim(hayoon) # 행렬 개수 
# group_by()와 같은 결과, excel의 countif()함수
table(hayoon$disease)


# 2019년 9월 28일 
library(stringr) #문자열 패턴 찾기  패키지 
# date 란 단어가 있는 칼럼 모두 찾기 
date_cols <- str_detect(names(hayoon), "date")
date_cols
library(lubridate)  #chr를 날짜로 변환하는 패키지 
# 하윤 데이터 칼럼에 date란 단어가 든 칼럼 날짜로 변환하기 
hayoon[ ,date_cols] <- lapply(hayoon[ ,date_cols], ymd) #lappy(데이터셋, 함수)
hayoon[ ,date_cols]
print(hayoon[ ,date_cols], n=100)
str(hayoon)
summary(hayoon)

# missing value 찾기
missing <- lapply(hayoon[,date_cols], is.na)
missing

num_missing <- sapply(missing, sum)
num_missing

# 10월 8일 GIT 테스트
hayoon %>%
  group_by(disease) %>%
  tally()







