﻿#Exercise 1
#Get all services where the display name begins with ‘Windows’.

Get-Service | where {$_.displayname -like 'windows*'}

#Exercise 2
#Get a list of all classic event logs on your computer.

Get-EventLog -List

#Exercise 3
#Find and display all of the commands on your computer 
#that start with ‘Remove’.

Get-Command -Name remove-* | measure
Get-Command -Verb remove   | measure


#Exercise 4
#What PowerShell command would you use to reboot one or more 
#remote computers?

Restart-Computer -ComputerName a, b

#Exercise 5
#How would you display all available modules installed on your computer?

Get-Module -ListAvailable

#Exercise 6
#How would you restart the BITS service on your computer and see the result?

Get-Service -Name BITS | Restart-Service

#Exercise 7
#List all the files in the %TEMP% directory and all subdirectories.

get-childitem -path  $env:TEMP  | `
Where-Object {$_.Attributes -EQ 'directory'}  


#Exercise 8
#Display the access control list (ACL) for Notepad.exe.

Get-Acl Notepad.exe | fl


#Exercise 9
#How could you learn more about regular expressions in PowerShell?

help about_Regular_Expressions

#Exercise 10
#Get the last 10 error entries from the System event log on your computer.

Get-EventLog -LogName System | Select-Object -Last 10

Get-WinEvent -LogName System | Select-Object -Last 10


#Exercise 11
#Show all of the ‘get’ commands in the PSReadline module.

Get-Command -Module PSReadline -Verb get

#Exercise 12
#Display the installed version of PowerShell.

$PSVersionTable

#Exercise 13
#How would you start a new instance of Windows 
#PowerShell without loading any profile scripts?

%windir%\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe -noprofile

#Exercise 14
#How many aliases are defined in your current PowerShell session?
# 170 individual alias
# 136 unique  alias

Get-Alias -Name *   | Group-Object Definition | measure

#Exercise 15
#List all processes on your computer that have a working set 
#size greater than or equal to 50MB and
#sort by working set size in descending order.


Get-Process | Where-Object {$_.WorkingSet -ge 50mb}

#Exercise 16
#List all files in %TEMP% that were modified in the last 24 hours and 
#display the full file name, its size
#and the time it was last modified. Write a PowerShell expression that 
#doesn’t rely on hard coded
#values.

get-childitem -path  $env:TEMP -file -Recurse| `
Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-1)} `
| Select-Object  @{name = "KB"; Expression = {[math]::round($_.length /1kb)}}, fullname


#Exercise 17
#Get all files in your Documents folder that are at least 1MB 
#in size and older than 90 days. Export
#the full file name, size, creation date and last modified date 
#to a CSV file. You may have to adjust
#the exercise based on files you have available.

Get-ChildItem -path 'C:\Users\LocalAdmin\Documents' -file -Recurse| `
Where-Object {$_.Length -gt 1mb -and $_.LastWriteTime -lt (Get-Date).AddDays(-90)} `
| Select-Object  @{name = "mb"; Expression = {[math]::round($_.length /1mb)}}, LastWriteTime, fullname | Export-Csv C:\Exercise17.csv


#Exercise 18
#Using files in your %TEMP% folder display the total number of each files 
#by their extension in
#descending order.

$ex = Get-ChildItem -Path $env:TEMP -file -Recurse | Group-Object extension  
$ex | ForEach-Object {$_}
$ex | measure


#Exercise 19
#Create an XML file of all processes running under your credentials.


Get-Process -IncludeUserName | where-object {$_.username -like '*localadmin*'} `
| Export-Clixml c:\powershell\ProcCred.xml



#Exercise 20
#Using the XML file you created in the previous question, import the XML data into your PowerShell
#session and produce a formatted table report with processes grouped by the associated company
#name.




#Exercise 21
#Get 10 random numbers between 1 and 50 and multiply each number by itself.

1..10 | ForEach-Object{($X = Get-Random -Minimum 1 -Maximum 50) * $X}


#Exercise 22
#Get a list of event logs on the local computer and create an HTML file that includes ‘Computername’
#as a heading. You can decide if you want to rename other headings to match the original cmdlet
#output once you have a solution working.





#Exercise 23
#Get modules in the PowerShell Gallery that are related to teaching.

Find-Module -name '*Teaching*'
Find-Module  | Where-Object {$_.description -like '*Teaching*' }


#Exercise 24
#Get all running services on the local machine and export the data to a json file. 
#Omit the required and dependent services. Verify by re-importing the json file.




#Exercise 25
#Test the local computer to see if port 80 is open.