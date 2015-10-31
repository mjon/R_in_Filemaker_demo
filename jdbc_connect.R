# this script is called from the Filemaker Pro database "R calc" via an Applescript
# before this script is called, R will have calculated an "answer" using Filemaker supplied field values and stored the id of the associated Filemaker record in "FMPid"

# install the package RJDBC if you don't already have it
library (RJDBC) # adds the RDJBC functions to the current R session

# tell R where the Filemaker Pro JDBC driver is located
drv <- JDBC("com.filemaker.jdbc.Driver", "/Library/Java/Extensions/fmjdbc.jar", "‘")

# connect to Filemaker Pro database named "R calc"
# note that the database must be open in Filemaker Pro, and ODBC/RDJBC sharing must be turned on (File:Sharing:Enable ODBC/JDBC Sharing)
R_calc_connect <- dbConnect(drv, "jdbc:filemaker://localhost:2399/R\ calc?user=Admin&password=test")

# add the calculated answer in R into the "answer" field in Filemaker
dbGetQuery (R_calc_connect, paste ("UPDATE calculation SET answer = ", answer, " WHERE id = ", FMPid, sep = ""))
# this spits out an error message concerning ".verify.JDBC.result" but it does work. dbSendQuery produces the same error. Shrug.

dbDisconnect(R_calc_connect)
