import os

import boto3
from dotenv import load_dotenv

load_dotenv()

TABLE_NAME = os.getenv("MONITORS_TABLE_NAME", "monitors")
ENDPOINT_URL = os.getenv("DYNAMODB_ENDPOINT_URL")  # None in real AWS -> boto3 uses the default endpoint
REGION = os.getenv("AWS_REGION", "us-east-1")

_dynamodb = boto3.resource("dynamodb", region_name=REGION, endpoint_url=ENDPOINT_URL)
_table = _dynamodb.Table(TABLE_NAME)


def put_monitor(monitor: dict) -> None:
    _table.put_item(Item=monitor)


def list_monitors() -> list[dict]:
    response = _table.scan()
    return response.get("Items", [])