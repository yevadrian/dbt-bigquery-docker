#!/usr/bin/python3

from google.cloud import bigquery
import numpy as np

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