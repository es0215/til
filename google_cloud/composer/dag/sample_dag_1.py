from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime

# DAGの設定
default_args = {
    'owner': 'composer',
    'depends_on_past': False,
    'start_date': datetime(2023, 10, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
}

dag = DAG(
    'composer_to_cloud_run',
    default_args=default_args,
    description='A simple DAG to call Cloud Run',
    schedule_interval=None,
)

# Cloud RunのエンドポイントURLを定義
CLOUD_RUN_URL = 'https://xxxxxx'

# Cloud Runにリクエストを送るPython関数
def call_cloud_run():
    import requests

    response = requests.get(CLOUD_RUN_URL)
    print(response.text)

# PythonOperatorを使用して関数を呼び出すタスクを追加
call_cloud_run_task = PythonOperator(
    task_id='call_cloud_run_task',
    python_callable=call_cloud_run,
    dag=dag,
)

# DAGのタスクの依存関係を定義
call_cloud_run_task
