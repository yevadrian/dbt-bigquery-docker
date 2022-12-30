#!/usr/bin/python3

from google.cloud import storage, bigquery
from urllib.request import urlopen
import numpy as np

try:
    client = storage.Client()
    print('Connection to Google Cloud Storage Success')
except:
    print('Connection to Google Cloud Storage Failed')

client.create_bucket('yellow_tripdata')
bucket = client.get_bucket('yellow_tripdata')

for x in ["%.2d" % i for i in np.arange(1,13)]:
    file = urlopen(f'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2019-{x}.parquet')
    blob = bucket.blob(f'yellow_tripdata_2019-{x}.parquet')
    blob.upload_from_string(file.read())
    print(f'[{x}/12] File Loaded to Google Cloud Storage')

try:
    client = bigquery.Client()
    print('Connection to Google BigQuery Success')
except:
    print('Connection to Google BigQuery Failed')

client.create_dataset('yellow_tripdata', exists_ok=True)
dataset = client.dataset('yellow_tripdata')

for x in ["%.2d" % i for i in np.arange(1,13)]:
    table_ref = bigquery.TableReference(dataset, f'yellow_tripdata_2019-{x}')
    source_uris = f'gs://yellow_tripdata/yellow_tripdata_2019-{x}.parquet'
    job_config = bigquery.LoadJobConfig(source_format='PARQUET', autodetect=True, write_disposition='WRITE_TRUNCATE')
    client.load_table_from_uri(source_uris, table_ref, job_config=job_config)
    print(f'[{x}/12] Data Loaded to Google BigQuery')