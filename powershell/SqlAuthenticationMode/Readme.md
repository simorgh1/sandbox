# SqlAuthenticationMode PowerShell module
Provides methods for SqlAuthenticationMode

## Import module

```
PS C:\SqlAuthenticationMode\ Import-module .\SqlAuthenticationMode.psm1
```

## Methods
## Set-SqlMixedAuthenticationMode
The default SqlAuthenticationMode can be set to the Mixed mode, so that sql server authentication can be used.

Help
```
PS C:\ Get-Help Set-SqlMixedAuthenticationMode -Detailed
```

Example:
```
PS C:\ Set-SqlMixedAuthenticationMode .\SQLEXPRESS 'MSSQL$SQLEXPRESS'
```