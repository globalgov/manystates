# Joining Slabs

cowslab1 <- cowslab %>% select(id, startdate, enddate)

isdslab1 <- isdslab %>% select(id, startdate, enddate)

slabs <- inner_join(cowslab, isdslab1)

#Returns only 29 rows because most dates do not match ...

slabs1 <- full_join(cowslab1, isdslab1)

#Returns 579 rows, many with repeated IDs. 

cowslice1 <- cowslice %>% select(id, startdate, enddate)

slabs <- inner_join(cowslab1, gwslab)

# 2 rows left ...

slabs1 <- full_join(cowslab1, gwslab)

# 480 rows left... We can keep yars only and see if this gets better. 

gwslabyear <- gwslab %>% transmutate(startyear = lubridate::year(startdate)) %>% transmutate(endyear = lubridate::year(enddate))

cowslabyear <- cowslab1 %>% transmutate(startyear = lubridate::year(startdate)) %>% transmutate(endyear = lubridate::year(enddate))

slabs2 <- inner_join(gwslabyear, cowslabyear)

# 12 obs left ... 

gwslabyear$endyear[gwslabyear$endyear == 9999] <- 2016

slabs2 <- inner_join(gwslabyear, cowslabyear)

# 140 obs left; not bad but far from ideal.  

