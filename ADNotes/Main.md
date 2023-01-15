# Layout

Hosts in the networkdomain
	- DC1
		- IP addr : 192.168.2.254/24
	- DC1 
		- Ip addr : 192.168.2.253/24
	- WS1 
		- Ip addr : 192.168.2.252/24
	- WS2 
		- Ip addr : 192.168.2.251/24
	- WS3 
		- Ip addr : 192.168.2.250/24

# Deployment

- Create the first VM of the lab with Windows Server 2022 on it, using the iso file through a virtual CD
- I'll do everything from that host

# Additional notes

- I'll manage everything from host WS1 that is part of the domain
- I've enabled RDP from Settings > Remote desktop
	- In this way i can use the WS1 host from my laptop, which is outside the domain

# General procedure

- Install the ADDS feature on the domain controller 

`Install-WindowsFeature AD-Domain-Services -IncludeManagementTools`

- Create the domain, the domain forest and install the DNS server 

	`Install-ADDSForest -DomainName allsafe.com -InstallDNS`

- We'll administer the DC using powershell from the WS1 host through a remote shell
	- Create an AD user account to use to log on to the DC1

		`New-ADUser -Name user1 -Password $Password`

	- Enable [WinRM](https://learn.microsoft.com/en-us/windows/win32/winrm/portal)(already enabled on windows server by default) service and add firewall rule (done automatically)
		
		`Enable-PSRemoting -Force`

		- Note : you need to run the powershell as admin to use this command
	- There must be a thrust relationship between the two host in order to get the remote shell. So we need to either 
		- Add the WS1 host to the domain

		- Or add DC1 to the thrusted hosts file

			`Set-Item wsman:localhost\client\trustedhosts -Value 192.168.20.254`

			- [What's wsman?](https://learn.microsoft.com/en-us/powershell/module/microsoft.wsman.management/about/about_wsman_provider?view=powershell-7.3)

	- Now enter the remote PSSession
		
		`Enter-PSSession HOSTNAME -Credential (Get-Credential)`



# Additional stuff

## Rename the host

	`Rename-Computer -NewName "name"`

## Create a new AD user account

- Take in the password in safe mode and store it in a variable

	`$Password = Read-Host -AsSecureString`

- Create the account

	`New-ADUser -Name "Levi" -AccountPassword $Password -Enabled $true`

## Add account to administrator group

	`Add-ADGroupMember -Identity Administrators -Members Levi`

## Add computer to domain. Type it from the computer you want to join

	`Add-Computer -DomainName allsafe.com -Restart`

## Copy file to another machine

	`Copy-Item FILE_PATH -ToSession SESSION_ID DESTINATION_PATH`

## Download file from url

	`Invoke-WebRequest -Uri "URI" -OutFile "OUTPUT_PATH"`
	