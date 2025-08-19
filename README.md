<h1>Building an SSM module and IAM role in Terraform</h1>

Learn how to build an AWS Systems Manager (SSM) module and an IAM role. The IAM Role gets assumed by the SSM service, allowing it to interact with EC2 instances using the permissions defined in the attached IAM policy.

<h2>Lab overview</h2>
AWS Systems Manager is a collection of capabilities that you can use to centralize operational data and automate tasks across your Amazon Web Services (AWS) resources. Systems Manager can configure and manage Amazon Elastic Compute Cloud (Amazon EC2) instances, on-premises servers, virtual machines, and other AWS resources at scale. 

With Session Manager, a capability of Systems Manager, you can manage your EC2 instances through an interactive one-step browser-based shell or through the AWS Command Line Interface (AWS CLI). Session Manager provides secure and auditable instance management without the need to open inbound ports, maintain bastion hosts, or manage SSH keys. You can also use Session Manager to help comply with corporate policies that require controlled access to instances, strict security practices, and fully auditable logs with instance access details while still providing end users with one-step cross-platform access to your EC2 instances.

<img width="533" height="176" alt="image" src="https://github.com/user-attachments/assets/572ef035-5096-420e-bc27-b326a9cbf4c9" />

In the preceding diagram, Systems Manager uses Session Manager to access the EC2 instance without having to connect to the instance by using SSH. Session Manager is one of the secure ways to access the instance.

We start by defining the module. 

Let’s first define the module by adding it to the bottom of our root main.tf file below the VPC block.

/main.tf

<img width="439" height="394" alt="image" src="https://github.com/user-attachments/assets/ba7f4c89-6cb5-47e3-b92c-de5591af8253" />

<h2>SSM Module Main File</h2>

Let’s begin creating the SSM module’s main.tf file. Refer to Amazon’s documentation on Default Host Management Configuration to learn more about the resources we’re creating in this module.

This section below creates two data sources to get the current region and account ID. This will allow us to reference the region and account ID in our resources without hardcoding them.

Modules/ssm/main.tf

<img width="497" height="164" alt="image" src="https://github.com/user-attachments/assets/13eda79f-e766-4a93-8d47-2c8ef76b01b4" />

This section below creates an IAM Role for SSM. The IAM Role gets assumed by the SSM service, allowing it to interact with EC2 instances using the permissions defined in the attached IAM policy. The IAM policy is a managed policy provided by AWS that grants the necessary permissions for SSM to interact with EC2 instances.

Modules/ssm/main.tf

<img width="522" height="265" alt="image" src="https://github.com/user-attachments/assets/d7e77f85-37c3-45da-961c-6b9b7bdd452d" />

modules/ssm/main.tf

<img width="739" height="141" alt="image" src="https://github.com/user-attachments/assets/2ef798ed-006a-4fc9-9cde-b68ea0609e38" />

<h2>SSM Module Outputs File</h2>

The outputs.tf file defines an output of the IAM Role’s name and arn created in this module. This allows us to easily reference and utilize this resource elsewhere if needed.

modules/ssm/outputs.tf

<img width="479" height="146" alt="image" src="https://github.com/user-attachments/assets/0ebd4c6e-f3fe-46ef-9a9e-8c9ae009f5cd" />

That’s it for the SSM module! Is time to test the deployment.

<h2>Configure your AWS CLI</h2>

<h3>Deploy the SSM Module</h3>

Since we’re adding a new module, we’ll need to initialize the terraform configuration again. Notice how the ssm module is now being initialized in the output below:

<img width="637" height="143" alt="image" src="https://github.com/user-attachments/assets/b70b7347-1c66-4e66-8f26-64c190f4cf9d" />
  
    Run terraform init command

<img width="542" height="301" alt="image" src="https://github.com/user-attachments/assets/17a36015-9c5e-4531-9f11-860ea44a2cf5" />
 
 Next is to run terraform apply

 <img width="828" height="448" alt="image" src="https://github.com/user-attachments/assets/d70429c6-c043-4444-83d1-81b841fe4eb6" />


<img width="946" height="257" alt="image" src="https://github.com/user-attachments/assets/d272386c-68e7-46b6-a39d-49fc3aa5a64d" />

<h3>Verifying configuration</h3>

We can leverage the AWS CLI to verify that the SSM service setting has been enabled in the region using the following command, but make sure you grab your own setting ID and not my example one. You can search in your terminal for “:servicesetting/ssm/managed-instance/default-ec2-instance-management-role” and it will display what you need to copy/paste.

    aws ssm get-service-setting --setting-id arn:aws:ssm:us-east-1:014498641646:servicesetting/ssm/managed-instance/default-ec2-instance-management-role

Use the ARN of the SSM service setting resource (can be seen in the output of the terraform apply command) to query the service setting. We know this is enabled successfully if the IAM Role we created is set as the value for SettingValue.

<img width="766" height="192" alt="image" src="https://github.com/user-attachments/assets/2218ea7c-4361-4467-888d-32a0dc3ed1fe" />

Terraform Destroy

<img width="707" height="68" alt="image" src="https://github.com/user-attachments/assets/6929c664-7763-447a-b8e5-d4e69baeda25" />





 



