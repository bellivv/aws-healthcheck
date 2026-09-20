import os

import boto3
from boto3.dynamodb.conditions import Key
from dotenv import load_dotenv

load_dotenv()

TABLE_NAME = os.getenv("MONITORS_TABLE_NAME", "monitors")
RESULTS_TABLE_NAME = os.getenv("RESULTS_TABLE_NAME", "results")
ENDPOINT_URL = os.getenv("DYNAMODB_ENDPOINT_URL")  # None in real AWS -> boto3 uses the default endpoint
REGION = os.getenv("AWS_REGION", "us-east-1")

_dynamodb = boto3.resource("dynamodb", region_name=REGION, endpoint_url=ENDPOINT_URL)
_table = _dynamodb.Table(TABLE_NAME)
_results_table = _dynamodb.Table(RESULTS_TABLE_NAME)


def put_monitor(monitor: dict) -> None:
    _table.put_item(Item=monitor)


def list_monitors() -> list[dict]:
    response = _table.scan()
    return response.get("Items", [])


def put_result(result: dict) -> None:
    _results_table.put_item(Item=result)


def list_results(monitor_id: str, limit: int = 20) -> list[dict]:
    response = _results_table.query(
        KeyConditionExpression=Key("monitor_id").eq(monitor_id),
        ScanIndexForward=False,  # False = descending, so newest checked_at comes first
        Limit=limit,
    )
    return response.get("Items", [])