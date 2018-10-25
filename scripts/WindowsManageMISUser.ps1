$ErrorActionPreference = "Stop"
$VerbosePreference="Continue"

# Create jenkins user
# Get our our password details from ssm
$keyname = "/$env:TARGET_ENV/jenkins/windows/mis"
$mis_user= (aws --region eu-west-2 ssm get-parameters --with-decryption --names "${keyname}/user" --query Parameters[0].Value)
$mis_password = (aws --region eu-west-2 ssm get-parameters --with-decryption --names "${keyname}/password" --query Parameters[0].Value)
$misCreds = New-Credential -UserName $mis_user -Password $mis_password
Install-User -Credential $misCreds

Add-GroupMember -Name Administrators -Member $mis_user