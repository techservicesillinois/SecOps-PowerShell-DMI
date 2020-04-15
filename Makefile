build:
	pwsh -NoProfile -WorkingDirectory ${CURDIR} -Command 'Copy-Item -Path ".\UofIDMI" -Destination "c:\program files\powershell\7\Modules" -Recurse -Force'
	pwsh -NoProfile -WorkingDirectory ${CURDIR} -Command 'Install-Module -Name PSSQLite -Force'