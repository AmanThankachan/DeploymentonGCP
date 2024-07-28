
### Step 1: Local Setup

1. **Clone the example voting app repository(have added the specific code volumes to be mounted in this repo itself):**
   - Run the following command to clone the repository:
     ```sh
     git clone https://github.com/dockersamples/example-voting-app.git
     cd example-voting-app
     ```

2. **Setup the application locally:**
   - Ensure you have Docker installed.The repository contains a Docker Compose file, which makes it easy to set up the application. Run the following command:
     ```sh
     docker-compose up
     ```
### Step 2: Infrastructure as Code (IaC) with Terraform

1. **Install Terraform**
   
2. **Set Up GCP:**
   - Ensure you have a GCP account and the `gcloud` CLI installed. Authenticate using:
     ```sh
     gcloud auth application-default login
     ```

3. **Terraform Configuration:**
   - Navigate to directory named `infrastructure`:
     ```sh
     cd infrastructure
     ```

4. **Terraform Files:**
   - `main.tf` This file contains the main configuration for your infrastructure.
   - `variables.tf` This file contains variable definitions for the project.
   - `outputs.tf` This file defines the outputs for your infrastructure.

5. **Initialize and Apply Terraform Configuration:**
   - Initialize Terraform:
     ```sh
     terraform init
     ```
   - Create a terraform.tfvars file to define the values for the variables:
     ```hc1
     project_id   = "your-gcp-project-id"
     region       = "us-central1"
     ssh_user     = "your-ssh-username"
     ssh_pub_key  = "/path/to/your/ssh/public/key"
     ```
   - Apply the configuration:
     ```bash
     terrform apply
     ```

### Step 3: CI/CD Pipeline

1. **Set Up A Gitlab CI/CD Pipeline:**
   - Setup a `.gitlab-ci.yml` file in the root of your repository with the corresponding file in this repository:
   - Need to add the variable values of the variables mentioned in the variables section as CI/CD variables to gitlab.
  
### Step 4: Configuration Management with Ansible

1. **Install Ansible:**

2. **SSH Access:** Ensure you have SSH access to your GCP Compute Engine instance.

3. **Ansible Configuration:**
   - `inventory.ini` defines the target hosts.
   - `playbook.yml` is the main playbook that will call the roles.
   - `roles/common/tasks/main.yml` handles common configurations like updating packages and installing dependencies.
   - `roles/app/tasks/main.yml` handles application-specific configurations.
   - `roles/app/templates/app.env.j2` contains environment variables for the application.
   - `roles/app/vars/main.yml` defines the variables for your environment. You can use Ansible Vault to encrypt sensitive data.
  
4. **Running the Playbook**
   ```sh
   ansible-playbook -i inventory.ini playbook.yml
   ```
    
