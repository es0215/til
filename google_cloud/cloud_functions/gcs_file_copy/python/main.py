from cloudevents.http import CloudEvent
import functions_framework

from google.cloud import storage
import os

@functions_framework.cloud_event
def gcs_copy_f1_to_f2(cloud_event: CloudEvent) -> tuple:
    # EventArc からのデータを取得
    data = cloud_event.data

    # プロジェクトIDを取得(環境変数)
    project_f1 = os.environ.get("PROJECT_ID", "PROJECT_ID is not set.")

    # Day2 変数を定義
    project_f2 = f"{project_f1}-f2"
    prefix     = data["bucket"].replace(f"{project_f1}-", "")
    bucket_f2  = f"{project_f2}-{prefix}"

    # source: Day1
    source_client = storage.Client(project=project_f1)
    source_bucket = source_client.bucket(data["bucket"])
    source_blob   = source_bucket.blob(data["name"])

    # destination: Day2
    destination_client = storage.Client(project=project_f2)
    destination_bucket = destination_client.bucket(bucket_f2)
    destination_blob   = destination_bucket.blob(data["name"])

    # コピー実行
    try:
        source_bucket.copy_blob(source_blob, destination_bucket, data["name"])
        print(f"gcs-copy-f1-to-f2: {prefix} Copy Success!!")
    except Exception as e:
        print(e)
  
