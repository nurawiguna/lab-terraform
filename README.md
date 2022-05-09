How to use this repo:
- Install terraform cli on your machine: https://www.terraform.io/downloads

- Choose the provider as you need.
  - AWS: https://www.terraform.io/docs/providers/aws/index.html
  - Azure: https://www.terraform.io/docs/providers/azurerm/index.html
  - Google: https://www.terraform.io/docs/providers/google/index.html
  - OpenStack: https://www.terraform.io/docs/providers/openstack/index.html
  - vSphere: https://www.terraform.io/docs/providers/vsphere/index.html
Provider GCP:
    - Install gcloud cli on your machine: https://cloud.google.com/sdk/docs/install
    - On your machine, run: gcloud auth application-default login
    - Create a project: https://console.cloud.google.com/apis/dashboard   (or use the one you already have)
    - Use command "terraform init" on the spesific directory. Example on directory "terrafom-gcp", Every you use this repo
    - terraform state list

Provider AWS:
    - Install aws cli on your machine: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html