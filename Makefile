build:
	pwsh -NoProfile -WorkingDirectory ${CURDIR} -Command 'Copy-Item -Path ".\UofIDMI" -Destination "$$ENV:ProgramFiles\powershell\7\Modules" -Recurse -Force'
	pwsh -NoProfile -WorkingDirectory ${CURDIR} -Command 'Install-Module -Name PSSQLite -Force'