# terraform-infra
This repo content the complete terraform infrastructure build

project/
├── README.md
└── vpc/
    ├── backend.tf         ✅ S3 backend config
    ├── main.tf            ✅ VPC, subnet logic
    ├── output.tf
    ├── provider.tf
    ├── variables.tf
    └── vpc.tfvars         ✅ Your input variables


cd vpc/

# Initialize the backend and providers
terraform init

# Optional: show plan
terraform plan -var-file="vpc.tfvars"

# Apply changes
terraform apply -var-file="vpc.tfvars"
