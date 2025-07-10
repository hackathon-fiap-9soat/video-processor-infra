# video-processor-infra

## 📦 Infraestrutura

Este projeto define a infraestrutura escalável para um sistema de processamento de vídeos utilizando AWS, Terraform.

---

### 🚀 Serviços provisionados:
- **Amazon VPC** (com sub-redes públicas e privadas)
- **Amazon RDS** (PostgreSQL com criptografia KMS)
- **Amazon S3** (armazenamento de vídeos)
- **Amazon SQS** (mensageria)
- **AWS KMS** (gerenciamento de chaves)
- **Security Groups**

---

### 📁 Estrutura do projeto
```
infra/
├── modules/
│   ├── rds/
│   ├── s3/
│   ├── sqs/
│   ├── kms/
│   ├── vpc/
│   └── security_groups/
│── main.tf
│── outputs.tf
│── providers.tf
│── variables.tf
└── versions.tf
```

---

### ✅ Pré-requisitos
- AWS CLI configurado com uma role que tenha permissões para provisionar recursos
- Terraform >= 1.3.0
- Terraform instalado localmente

---

### 🛠️ Variáveis esperadas (`dev.tfvars`)

```
db_name                   = "video_processor"
db_user                   = "postgres"
db_password               = "12345678"
db_instance_class         = "db.t3.micro"
db_allocated_storage      = 20
db_max_allocated_storage  = 100
db_backup_retention_period = 1
multi_az                  = false
environment               = "dev"
project_name              = "video-processor"
```

---

### 🔐 GitHub Secrets obrigatórios
Configure os seguintes secrets no seu repositório:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `DB_NAME`
- `DB_USER`
- `DB_PASSWORD`

---

### 📦 Deploy local
```bash
cd infra/environments/dev
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

---

### ⚙️ Deploy automático com GitHub Actions
A cada `push` na branch `main`, a pipeline é executada automaticamente. Ver `.github/workflows/terraform.yml`

---

### 📌 Observações
- O `force_destroy = true` no S3 permite exclusão sem restrições — mantenha isso apenas em `dev`
- O backup do RDS está como 1 dia — para produção, configure pelo menos 3
- O `multi_az` está desativado — ative em produção para alta disponibilidade

---

### 📞 Suporte
Dúvidas? Abra uma issue ou entre em contato com o responsável pela infraestrutura.

---

# dev.tfvars

```
db_name                   = "fastfood"
db_user                   = "postgres"
db_password               = "12345678"
db_instance_class         = "db.t3.micro"
db_allocated_storage      = 20
db_max_allocated_storage  = 100
db_backup_retention_period = 1
multi_az                  = false
environment               = "dev"
project_name              = "video-processor"
