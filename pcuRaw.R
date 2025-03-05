options(scipen = 999)
library(RODBC); #library(tidyverse); 
# setwd("O:/Alaska/Depts/Kenai/OptEng/drt/projects/Integrated Gas Model/Pretty_Creek_Storage")

# Well Information
wi <- data.frame(WELL_KEY = '50.0603.0001',
                 WELL_NAME = 'PC 4',
                 WELL_RES = 'BG.51-5_ST.45-0')

q <- paste0("SELECT top 20 [DATE_TIME], '", wi$WELL_KEY[1],"' as WELL_KEY,
      sum([GAS_PRODUCTION_VOLUME]) as Gas,
      sum([OIL_PRODUCTION_VOLUME]) as Oil,
      sum([WATER_PRODUCTION_VOLUME]) as Water,
      sum([WATER_INJECTION_VOLUME]) as InjWtr,
      sum([GAS_INJECTION_VOLUME]) as InjGas,
	    sum([GAS_LIFT_INJECTION_VOLUME]) as InjGasLift,
      max([TUBING_PRESSURE]) as TbgPress,
      max([CASING_PRESSURE]) as CsgPress
      
      FROM [HEC_Enertia].[dbo].[PRODUCTION_HISTORY] 
      where [WELL_KEY] like '", wi$WELL_KEY[1], "%' ",
            "group by DATE_TIME order by DATE_TIME")

str <- paste0('driver=SQLServer;',
              'server=enertia01;',
              'database=HEC_Enertia;',
              'trusted_connection=yes')

# query 
cn <- RODBC::odbcDriverConnect(str)
prd <- RODBC::sqlQuery(cn, q)
RODBC::odbcClose(cn)

# is the df empty
if(dim(prd)[[1]] == 0) {
  print('no data')
  break
}

# Where Csg and Tbg pressures are NA make 0
prd$CsgPress[is.na(prd$CsgPress)] <- 0
prd$TbgPress[is.na(prd$TbgPress)] <- 0

production <- left_join(prd, wi, by = 'WELL_KEY')


str <- paste0('driver={SQL Server};',
              'server=ancsql04;',
              'database=Gas_Forecasting_Sandbox;',
              'trusted_connection=true')

cn <- RODBC::odbcDriverConnect(str)
RODBC::sqlClear(cn, sqtable = 'pcu_storage_all')
RODBC::sqlSave(cn,
               production,
               rownames = F,
               append = T,
               tablename = 'pcu_storage_all')
RODBC::odbcClose(cn)
