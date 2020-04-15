# What is This?
This is a PowerShell integration for Division of Management Information at University of Illinois at Urbana-Champaign. This is the system used to join information from sources like CDB to find out who an asset belongs to.

# How do I install it?
1) Install Powershell 7, you have options for this. [Chocolaety](https://chocolatey.org/packages/powershell-core) or [GitHub](https://github.com/PowerShell/PowerShell/releases).
2) For the current GA release you can use the [PSGallery](https://www.powershellgallery.com/packages/UofIDMI) or you can use the Makefile provided to set set it up from the repository.

# How does it work?
1) Using the URL specified in the settings.json file DMI information will be fetched via the provided unauthenticated tab seperated web page.
2) This information is then stored in a local SQLite database for better performance and to ensure the data is available if the webpage is down.
3) By default the module will update the local DB from the URL at import unless UpdateCacheOnImport is set to false in settings.json.
4) Typical use after installing is just going straight to the Get-DMIDepartment command after opening your shell.

# How do I help?
1) Ensure naming schemes are kept consistent with the Verb-DMINoun convention.
2) Ensure the docs folder is kept up to date as well as the comment based help. The docs are generated via the PlatyPS module available on the PS Gallery.
3) Any new functionality should have associated pester tests added to the UofIDMI.Tests.ps1 file and by extension no PR should be accepted without passing pester tests.

# To Do
1) Do the following after [this](https://github.com/RamblingCookieMonster/PSSQLite/pull/26) pull request is merged into PSSqlite
   1) Remove '-As DataRow' references from Get-DMIDepartment and Update-DMICache
   2) Update manifest to require the new version of PSSqlite
   3) Officially declare Mac/Linux support