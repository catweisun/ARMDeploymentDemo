#ARM Template Deployment Demo
This repository contains a set of Powershell scripts and ARM template to deploy demo environment.
##Setup steps
1. prepare your Azure China subscription
2. Run the publishDscPackage.ps1 to setup DSC moudle and upload module to public storage container
3. Run the deploy.ps1 to provision Jumpbox VM with password and VM count parameters
4. Once completed the demo, execute cleanup.ps1 to delete the jumpbox VM deployment including Public IP address, Storage Account, VM and NIC resources
