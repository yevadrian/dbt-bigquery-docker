### Data Pipeline with dbt, Google Cloud Plaform, and Docker

The example dataset is a record of trips made by New York City’s iconic yellow taxis that have been recorded and provided to the TLC since 2009. 
This project contains scripts that help you to load the example dataset from data sources to your Google BigQuery.
All required tools and dependencies are compiled into the Docker Compose file.

##### Clone this repository and enter the directory
```bash
git clone https://github.com/yevadrian/dbt-bigquery-docker && cd dbt-bigquery-docker
```

##### Create a file named "service-account.json" containing your Google service account credentials
```json
{
  "type": "service_account",
  "project_id": "[PROJECT_ID]",
  "private_key_id": "[KEY_ID]",
  "private_key": "-----BEGIN PRIVATE KEY-----\n[PRIVATE_KEY]\n-----END PRIVATE KEY-----\n",
  "client_email": "[SERVICE_ACCOUNT_EMAIL]",
  "client_id": "[CLIENT_ID]",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://accounts.google.com/o/oauth2/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/[SERVICE_ACCOUNT_EMAIL]"
}
```

##### Create big data tools stack with Docker Compose
```bash
sudo docker compose up -d
```

##### Load data from data sources to Google Cloud Storage
```bash
sudo docker exec -it dbt bash -c "python3 load_gcs.py"
```

##### Load data from Google Cloud Storage to Google BigQuery
```bash
sudo docker exec -it dbt bash -c "python3 load_bigquery.py"
```

##### Test your dbt project connection
```bash
sudo docker exec -it dbt bash -c "dbt debug"
```

##### Load seed files to Google BigQuery
```bash
sudo docker exec -it dbt bash -c "dbt seed"
```

##### Execute the dbt project
```bash
sudo docker exec -it dbt bash -c "dbt run"
```

##### Create the dbt documentation
```bash
sudo docker exec -it dbt bash -c "dbt docs generate"
```

##### Deploy the dbt documentation
```bash
sudo docker exec -it dbt bash -c "dbt docs serve"
```

##### View the dbt documentation
```bash
localhost:8080
```