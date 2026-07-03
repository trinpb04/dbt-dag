import os
import sys
from datetime import datetime

from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping


profile_config = ProfileConfig(
    profile_name="dbt_dtpipeline",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="MSGEAVM-KP85536",
        profile_args={"database": "DBT_DB", "schema": "dbt_schema"},
    ),
)

dbt_snowflake_dag = DbtDag(
    project_config=ProjectConfig(os.path.join(os.path.dirname(__file__), "dbt-datapipeline-0")),
    operator_args={"install_deps": True},
    profile_config=profile_config,
    execution_config=ExecutionConfig(dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_venv/bin/dbt"),
    schedule="@daily",
    start_date=datetime(2024, 7, 3),
    catchup=False,
    dag_id="dbt_dag",
)