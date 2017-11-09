::BACKUP SCRIPT
::ROBOCOPY required to run this shit
::by zHadrava
::use it at your own risc
@ECHO OFF

::VARIABLE SECTION
::set source path, target path, path for logs and log name
SET source=C:\Path\to\files
SET target=D:\Path\to\backup
SET path_to_log=E:\Path\to\logs\
::date formating is specific for every localization of Windows, some tweaking will be required for desired output
SET log_name=ROBO-%date:~11,4%%date:~7,2%%date:~3,2%-%time:~0,2%%time:~3,2%.log

::Switches used in robocopy command
::/MIR : MIRror a directory tree - create exact copy of source folder in target
::/W:5 : Wait time between retries in seconds
::/XA:H : eXclude files with any of the given Attributes - H=Hidden
::/TEE : Output to console window, as well as the log file.
::/NP : No Progress - don’t display % copied. - becouse it will spam LOG file


::RUN SECTION
::modify at your own risc

::check if source, target and log path exist...
ECHO Verifiing user defined paths....
IF EXIST %source% (IF EXIST %target% (IF EXIST %path_to_log% (SET pass=1) ))
IF %pass%==1 ( 
 ECHO PASSED!
 ECHO Starting backup...
 robocopy %source% %target% /MIR /W:5 /XA:H /TEE /NP /LOG:%path_to_log%%log_name% 
 ) ELSE ( 
 ECHO.ERROR: Failed to verify user defined folder paths! Check them again! Faggot! 
 )
