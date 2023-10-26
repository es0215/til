import os
import requests
from slack_sdk import WebClient

# URLを変数化
url = os.getenv("TARGET_URL") or "https://example.com"
previous_content = ""

slack_api_token = os.getenv("SLACK_API_TOKEN")

def get_content():
    response = requests.get(url)
    return response.content

def notify_slack(message):
    client = WebClient(token=slack_api_token)
    client.chat_postMessage(channel="#general", text=message)

if __name__ == "__main__":
    current_content = get_content()
    if current_content != previous_content:
        notify_slack("The site has been updated!")
        previous_content = current_content
