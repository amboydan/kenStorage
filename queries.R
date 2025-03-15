
kenStorageWells <- function() {
  
  q = "select * from PDW.vwDIM_PDW_WELL where asset_team_nm = 'Kenai - KEN' and field_nm like '%Storage%'"
  
  str <- paste0('driver={SQL Server};',
                'server=cdhsqlprod.hilcorp.com;',
                'database=DW_FINANCE;',
                'trusted_connection=true')
  
  cn <- RODBC::odbcDriverConnect(str)
  wells <- RODBC::sqlQuery(cn, q)
  RODBC::odbcClose(cn)
  
  return(wells)
}

wellPressures <- function(wellName="") {
  
  q = paste0("select asset_team_nm as Asset, ", 
             "field_nm as Field, ", 
             "well_nm as Well, ", 
             "actual_date as Date, ", 
             "Gas = 0, ",
             "Inj = 0, ",
             "tubing_pressure_psi as TP, ", 
             "IA, OA ", 
             "from PDW.vwPDW_WELL_PRESSURE_WITH_HIERARCHY where ",
             "well_nm = '", wellName, "' ",
             "order by actual_date desc")
  
  str <- paste0('driver={SQL Server};',
                'server=cdhsqlprod.hilcorp.com;',
                'database=DW_FINANCE;',
                'trusted_connection=true')
  
  cn <- RODBC::odbcDriverConnect(str)
  press <- RODBC::sqlQuery(cn, q)
  RODBC::odbcClose(cn)
  
  return(press)
}

wellProductionUOM <- function(wellName="") {
  
  q = paste0("select asset_team_nm as Asset, ", 
             "field_nm as Field, ", 
             "well_nm as Well, ", 
             "prod_date as Date, ",
             "gas_calculated_production as Gas, ",
             "Inj = 0, ",
             "TP = 0, ",
             "IA = 0, OA = 0 ", 
             "from PDW.vwPRODUCTION_VOLUMES_BY_DAY where ",
             "well_nm = '", wellName, "' and ",
             "gas_calculated_production > 0 ",
             "order by prod_date desc")
  
  str <- paste0('driver={SQL Server};',
                'server=cdhsqlprod.hilcorp.com;',
                'database=DW_FINANCE;',
                'trusted_connection=true')
  
  cn <- RODBC::odbcDriverConnect(str)
  prod <- RODBC::sqlQuery(cn, q)
  RODBC::odbcClose(cn)
  
  return(prod)
}
wellProductionEnertia <- function(wellName="") {
  
  q = paste0("select asset_team_nm as Asset, ", 
             "field_nm as Field, ", 
             "well_nm as Well, ", 
             "prod_date as Date, ",
             "gas_calculated_production as Gas, ",
             "Inj = 0, ",
             "TP = 0, ",
             "IA = 0, OA = 0 ", 
             "from PDW.vwPRODUCTION_VOLUMES_BY_DAY_ARCHIVE where ",
             "well_nm = '", wellName, "' and ",
             "gas_calculated_production > 0 ",
             "order by prod_date desc")
  
  str <- paste0('driver={SQL Server};',
                'server=cdhsqlprod.hilcorp.com;',
                'database=DW_FINANCE;',
                'trusted_connection=true')
  
  cn <- RODBC::odbcDriverConnect(str)
  prod <- RODBC::sqlQuery(cn, q)
  RODBC::odbcClose(cn)
  
  return(prod)
}

wellInjectionUOM <- function(wellName="") {
  
  q = paste0("select asset_team_nm as Asset, ", 
             "field_nm as Field, ", 
             "well_nm as Well, ", 
             "prod_date as Date, ",
             "Gas = 0, ",
             "gas_injected as Inj, ",
             "TP = 0, ",
             "IA = 0, OA = 0 ",  
             "from PDW.vwPRODUCTION_VOLUMES_BY_DAY where ",
             "well_nm = '", wellName, "' and ",
             "gas_injected > 0 ",
             "order by prod_date desc")
  
  str <- paste0('driver={SQL Server};',
                'server=cdhsqlprod.hilcorp.com;',
                'database=DW_FINANCE;',
                'trusted_connection=true')
  
  cn <- RODBC::odbcDriverConnect(str)
  prod <- RODBC::sqlQuery(cn, q)
  RODBC::odbcClose(cn)
  
  return(prod)
}
wellInjectionEnertia <- function(wellName="") {
  
  q = paste0("select asset_team_nm as Asset, ", 
             "field_nm as Field, ", 
             "well_nm as Well, ", 
             "prod_date as Date, ",
             "Gas = 0, ",
             "gas_injected as Inj, ",
             "TP = 0, ",
             "IA = 0, OA = 0 ", 
             "from PDW.vwPRODUCTION_VOLUMES_BY_DAY_ARCHIVE where ",
             "well_nm = '", wellName, "' and ",
             "gas_injected > 0 ",
             "order by prod_date desc")
  
  str <- paste0('driver={SQL Server};',
                'server=cdhsqlprod.hilcorp.com;',
                'database=DW_FINANCE;',
                'trusted_connection=true')
  
  cn <- RODBC::odbcDriverConnect(str)
  prod <- RODBC::sqlQuery(cn, q)
  RODBC::odbcClose(cn)
  
  return(prod)
}
