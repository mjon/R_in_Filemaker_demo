# R_in_Filemaker_demo
This is a demo Filemaker database that connects to R via Applescript on a Mac. Filemaker database becomes the user interface for doing a particular task in R, using the data stored in Filemaker.

This database is my first attempt at running calculations in R triggered from a Filemaker database and having the results return to Filemaker. In other words, the Filemaker database becomes the user interface for doing a particular task in R, using the data stored in Filemaker.

For this to work, you'll need a copy of the Filemaker app (http://filemaker.com). It was built in Filemaker Pro Advanced 13 and should run on any Filemaker version  13 or higher, perhaps 12 too although I've not tried that. You'll also need R (http://r-project.org), and inside R you'll need to install the package RJDBC. You'll need all this running on a Mac because it uses Applescript to glue Filemaker and R together.

In short, here's how to use it and what it's doing:

1) Open the database "R calc" in Filemaker. The user is "Admin" and the password is "test".

2) In Filemaker, select File:Sharing:Enable ODBC/JDBC... Turn on ODBC/JDBC Sharing and select the "R calc" database from the list and allow access for the user Admin (using Specify users by privilege set). This lets R get to the database. You only need to do this set-up once.

3) Make a new record or alter an existing record, changing values of "input one", "input two", and/or "maths". Press the blue "Calculate in R" button.

4) This button runs the Filemaker script "calculate in R", which contains an Applescript that runs R. Note that before the Applescript, this script also moves the cursor to a hidden field called "park", since I've found that if one of the fields involved in the R calculation is selected when the script runs, it can interfere with the JDBC connection. Or something. It doesn't work properly anyway. If you want to see the Applescript, have a look inside the script "calculate in R" (Scripts: Manage Scripts...).

5) That should be all. The script will send the inputs to R, R will run the calculation and send the answer back to the field "answer".

As I mention on the database, this is a simple demo. Doing much more complicated things in R from Filemaker should be just as simple.


#KNOWN ISSUES

There is something still not quite right with my JCDB connection from R to Filemaker. It works, but triggers an error in R at the dbGetQuery step. For example,

Error in .verify.JDBC.result(r, "Unable to retrieve JDBC result set for ",  : 
  Unable to retrieve JDBC result set for UPDATE calculation SET "answer" = 95 WHERE "id" = 1 ([FileMaker][FileMaker JDBC] No results were returned by the query.)

The same thing happens when I use the dbSendQuery function.

While everything works, an outcome of this error is that when the database is closed in Filemaker, a window pops asking for JDBC connections to be closed. Just press "OK". Please let me know if you solve this. I've found other people on the internet having the same issue with RJDBC but haven't found a solution.


#ATTRIBUTION

This is creative commons attribution 4.0. Do what you like with it.

Jon.Sullivan@lincoln.ac.nz
http://jonsullivan.canterburynature.org
