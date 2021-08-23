# Task 6 Programming Challenge

This project assumes the following

 1. You are using ubuntu machine  	
 2. You have the following packages installed
	 - git
	 - terraform
	 - aws cli
	 - ssh 	
 3. you have aws credentials configured

## Rationale
- I have chosen to execute the python/go scripts in an app server hosted in ec2. Its a simple way to run the programs without complicating the scripts.
- I have chosen to place the python/go scripts in their own repositories and clone it via remote-exec so that the codes are decoupled from the infra scripts.
- I have chosen to allow terraform to generate the private keys dynamically instead of assigning a fixed private key because in this context, we do not need to maintain a fixed key. In an actual environment, in most cases this is not applicable.

## Instructions to execute the terraform script
Please execute the following steps to access the programs

 1. login to your ubuntu machine
 2. clone this repository
 3. navigate to the directory
 4. Initialize terraform
	<br />`terraform init`
 5. Apply terraform configuration
    <br />`terraform apply`
 6. when prompted to enter a value, press "Enter"
 7. take note of the output value of **<instance_public_ip>**
 8. Extract the auto-generated private key. The below command will print out the value of **<private_key>**
 	<br />`terraform output -raw private_key`
 9. copy the string of the output
 10. create a private key file
 	<br />`sudo vi task6_key.pem`
 11. paste the **<private_key>** string and save
 12. Change the file permission of the key file
 	<br />`sudo chmod 400 task6_key.pem`
 13. SSH login to the newly provisioned ec2 server
	<br />`sudo ssh -i task6_key.pem ubuntu@<instance_public_ip>`

## Executing the Python program
 1. Navigate to python folder
 	<br />`cd /home/ubuntu/task6/python/task6_python`
 2. Execute python program
	<br />`python3 task6.py`

## Executing the Golang program
 1. Navigate to golang folder
 	<br />`cd /home/ubuntu/task6/golang/task6_golang/`
 2. execute golang program
 	<br />`go run task6.go`

## De-provisioning programs
 	`exit`
 	`terraform destroy`
