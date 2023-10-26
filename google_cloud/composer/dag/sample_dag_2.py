from airflow import DAG
from airflow.providers.http.operators.http import SimpleHttpOperator
from airflow.operators.bash import BashOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'composer',
    'depends_on_past': False,
    'start_date': days_ago(1),
    'retries': 1,
}

# Cloud RunのエンドポイントURLを定義
CLOUD_RUN_URL = 'https://xxxxxx'

with DAG(
    'invoke_cloud_run_dag',
    default_args=default_args,
    schedule_interval=None,  # You can set a schedule interval here if needed
    catchup=False,) as dag:

    print_token = BashOperator(
        task_id='print_token',
        bash_command=f'gcloud auth print-identity-token "--audiences={CLOUD_RUN_URL}"'
    )

    token = "{{ task_instance.xcom_pull(task_ids='print_token') }}" # gets output from 'print_token' task

    invoke_cloud_run_task = SimpleHttpOperator(
        task_id='invoke_cloud_run',
        method='GET',
        http_conn_id='cloud-run-test',  # You need to create an Http connection with the appropriate base URL
        endpoint='/',
        headers={'Authorization': 'Bearer ' + token },
        dag=dag,
    )

    print_token >> invoke_cloud_run_task
