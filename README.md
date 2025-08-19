
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

<img width="626" height="445" alt="image" src="https://github.com/user-attachments/assets/eaacf924-5e3a-47a2-9b1b-b62573b77b1e" />

modules/ssm/main.tf

<img width="739" height="141" alt="image" src="https://github.com/user-attachments/assets/2ef798ed-006a-4fc9-9cde-b68ea0609e38" />

<h2>SSM Module Outputs File</h2>

he outputs.tf file defines an output of the IAM Role’s name and arn created in this module. This allows us to easily reference and utilize this resource elsewhere if needed.

modules/ssm/outputs.tf

<img width="624" height="196" alt="image" src="https://github.com/user-attachments/assets/c8d3a75d-3c3f-45b9-881f-2b4fe40093e6" />

Conclusion
That’s it for the SSM module! Not too much going on. We’ve defined the code for an IAM Role and SSM regional configuration, and now we’re ready to test it out by deploying which we’ll do in the next lab!


