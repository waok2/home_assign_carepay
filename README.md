# simple_ec2_terraform_nginx_ansible

We use Terraform to spin the EC2 instance and Ansible to install Nginx and configure it.

### Prerequisites 
-  Pragmatic access to AWS with EC2 full access  
- Key pair for ssh connection or to EC2
- Terraform and ansible installed 


## Instructions 
1. update EC2 varialbles in 
```bash
 variables.tf 
```
2. use the command below to provision the infrastructure  
```bash 
terraform init

terraform apply 
``` 
note; i have commented out a part on attaching  a data disk, if it is needed the block can be uncommented.

3. From the Terraform state file {```terraform.tfstate ```} get the elastic IP and update it in the Ansible inventory file {```ansible-nginx/inventory.yaml```}
4. Run the Ansible playbook using the command below 
```bash 
ansible-playbook -i ansible-nginx/inventory.yaml  ansible-nginx/playbook.yaml
```

### HTTPS
I have commented some lines in the ansible-playbook, the lines are meant if we want to use self-signed SSL certificates for HTTPS or rather be modified to use CA SSL certificates.  

## Bonus Task 
Both the deployment config and the service are included in the yaml file {```nginx-kubernetes-config/nginx-deployment.yaml ```  }. NodePort service is used to expose the app on port 30007, a loadblancer can be used depending on the infrastructure or cloud platform to be used. Use ```kubectl apply -f nginx-kubernetes-config/nginx-deployment.yaml``` to implement the deployment and service. 




