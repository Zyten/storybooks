PROJECT_ID=traversy-crash-course

run-local:
	docker-compose up -d

###

create-tf-backend-bucket:
	gsutil mb -p $(PROJECT_ID) gs://$(PROJECT_ID)-terraform

###

ENV=staging

terraform-create-workspace:
	cd terraform && \
	terraform workspace new $(ENV)

terraform-init:
	cd terraform && \
	terraform workspace select $(ENV) && \
	terraform init

