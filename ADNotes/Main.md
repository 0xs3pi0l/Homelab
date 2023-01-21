# Layout

Hosts that will be in the domain

- DC1
	- IP addr : 192.168.2.254/24
- DC2
	- Ip addr : 192.168.2.253/24
- WS1 
	- Ip addr : 192.168.2.252/24
- WS2 
	- Ip addr : 192.168.2.251/24
- WS3 
	- Ip addr : 192.168.2.250/24

# Deployment

## Initial considerations
- Create the first VM of the lab with Windows Server 2019 on it, using the iso file, through a virtual CD
	- I will then upgrade it to windows server 2022
		- Note : before upgrading, you need to install all the updates that are available
		- To check if there are pending updates, go into settings > updates and security
	- I'll do everything from that host
- I'll use [Windows Deployment Services](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831764(v=ws.11)) to automate the deployment phase for every host in the domain

## -------

- Create the [answer file](https://learn.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/answer-files-overview)
	- Download the windows [ADK](https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install) from [here](https://go.microsoft.com/fwlink/?linkid=2162950) 
		- Select only the deployment tools features 
	- Open the [Windows System Image Manager](https://learn.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/windows-system-image-manager-technical-reference)
	- Copy the windows.img file from the mounted iso to a folder
	- Add it from the GUI
		- It might happen that the install file has the .esd extension instead
			- It's the encrypted version of the .wim file
			- To obtain the .wim file use the [DISM tool](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/what-is-dism?view=windows-11)
				- Create a folder to temporary mount the image file 
				- Open a cmd as admin and type 
					```
					dism /export-image /SourceImageFile:<path to .esd file> /SourceIndex:2 /DestinationImageFile:<destination path for .wim file> /Compress:max /CheckIntegrity

					```
					- To find the index number type
						```
						dism /get-imageinfo /imagefile:<path to .esd file>
						```
	- If it doesn't create a new answer file on the right automatically, click File > New answer file
	- Search for the component "amd64_Microsoft-Windows-Setup_NUM_neutral" and add it to the answer file
		- Every [configuration](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-setup-configuration-passes?view=windows-11) pass specifies a phase of the Windows setup process 
	- We can also add packages to the answer file 
	- Save it somewhere and call it "autounatted" otherwise it won't work?
- Now we need to install the ADDS feature, create a domain, join the server to the domain and install the DHCP and the DNS features
	- ADDS installation is already documented in the AD file
	- DNS setup
		- Install the DNS feature on the server through powershell `Install-WindowsFeature DNS -IncludeManagementTools` or trhough the Server Manager GUI
		- I've installed it toghether with ADDS so all the zone files are already configured
	- DHCP setup
		- Install with `Install-WindowsFeature DHCP -IncludeManagementTools` or through the GUI
		- Use the management tool from the GUI to create a new scope 
	- Note : both DNS and DHCP configurations can be done through powershell as well
- Install the WDS feature 
	- Type `Install-WindowsFeature WDS -IncludeManagementTools` 

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
	