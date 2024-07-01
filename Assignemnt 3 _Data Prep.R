library(tidyverse)
library(knitr)
library(bslib)
Stromdata<- as.data.frame(StormEvents_details_ftp_v1_0_d2017_c20230317)
Newvars<- Stromdata%>%
  select(BEGIN_YEARMONTH,EPISODE_ID,STATE,STATE_FIPS,CZ_NAME,CZ_TYPE,CZ_FIPS,EVENT_TYPE)%>%
  arrange(STATE) %>%
  filter(CZ_TYPE == "C") %>%
  select(BEGIN_YEARMONTH,EPISODE_ID,STATE,STATE_FIPS,CZ_NAME,CZ_FIPS,EVENT_TYPE)
  
str_to_title(Newvars$STATE)
str_pad(Newvars$STATE_FIPS,width = 3,side="left",pad="0")

Newvars<- Newvars%>%
  rename_all(tolower)
  
 data("state") 
 
 us_state_info<-data.frame(state=state.name, region=state.region, area=state.area)
 table(Newvars$state)
 
 Newset<- data.frame(table(Newvars$state))
 
 newset1<-rename(Newset, c("state"="Var1"))
 merged <- merge(x=newset1,y=us_state_info,by.x="state", by.y="state")
 newset2<-mutate_all(us_state_info,toupper)
 merged <- merge(x=newset1,y=newset2,by.x="state", by.y="state")

library(ggplot2)
 stormplot<-ggplot(merged, aes(x= area, y = Freq))+
   geom_point(aes(color= region))+
   labs(x = " Land area ( sqaure miles)",
         y= " # of storm events")
   
 
 stormplot

