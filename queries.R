
ken_storage_wells <- function() {
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