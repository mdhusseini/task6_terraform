# Task 6 Programming Challenge

This project assumes the following

 1. You are using ubuntu machine  	
 2.  You have the following packages installed
	 - git
	 - terraform
	 - aws cli
	 - ssh 	
   3. you have aws credentials configured

## Provisioning the terraform resources
Please execute the following steps to access the programs

 1. login to your ubuntu machine
 2. clone this repository
 3. navigate to the directory
 4. Initialize terraform
	`terraform init`
 5. Apply terraform configuration
    `terraform apply`
 6. when prompted to enter a value, press "Enter"
 7. take note of the output value of **<instance_public_ip>**
 8. Extract the auto-generated private key. The below command will print out the value of **<private_key>**
 	`terraform output -raw private_key`
 9. copy the string of the output
 10. create a private key file
 	`sudo vi task6_key.pem`
 11. paste the **<private_key>** string and save
 12. Change the file permission of the key file
 	`sudo chmod 400 task6_key.pem`
 13. SSH login to the newly provisioned ec2 server
	`sudo ssh -i task6_key.pem ubuntu@<instance_public_ip>`

## Executing the Python program
 1. Navigate to python folder
 	`cd /home/ubuntu/task6/python/task6_python`
 2. Execute python program
	`python3 task6.py`

## Executing the Golang program
 1. Navigate to golang folder
 	`cd /home/ubuntu/task6/golang/task6_golang/`
 2. execute golang program
 	`go run task6.go`

## De-provisioning programs
 	`exit`
 	`terraform destroy`