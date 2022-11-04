#!/bin/bash

mkdir ${AIRFLOW_HOME}/logs
chown 50000:0 ${AIRFLOW_HOME}/logs ${AIRFLOW_HOME}/plugins

cd ${AIRFLOW_HOME}/transform/data_warehouse && dbt clean && dbt deps
psql postgresql://airflow:airflow@192.168.1.3:5432/postgres -c "SELECT 1 FROM pg_database WHERE datname = 'data_warehouse'" | grep -q 1 || psql postgresql://airflow:airflow@192.168.1.3:5432/postgres -c "CREATE DATABASE data_warehouse"
cd $AIRFLOW_HOME
airflow db init;
exec airflow scheduler

