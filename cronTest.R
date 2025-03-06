n <- sample(1:15, 1)

str <- paste0(
  "driver=ODBC Driver 18 for SQL Server;", 
  "server=ancsql04.hilcorp.com;", 
  "database=Gas_Forecasting_Sandbox;",
  "port=1433;",
  "uid=gasforecast;",
  "pwd=Hilc0rp_101!;",
  "TrustServerCertificate=yes"
)

q <- paste0("select * from pcu_storage_all")

cn <- RODBC::odbcDriverConnect(str)
prd <- RODBC::sqlQuery(cn, q)

write.csv(prd, 'prd.csv', row.names = F)
