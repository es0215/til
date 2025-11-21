import os
import time

import requests
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

# 監視対象の URL と Slack 設定
URL = os.getenv("TARGET_URL", "https://example.com")
SLACK_API_TOKEN = os.getenv("SLACK_API_TOKEN")
SLACK_CHANNEL = os.getenv("SLACK_CHANNEL", "#general")
CHECK_INTERVAL_SECONDS = int(os.getenv("CHECK_INTERVAL_SECONDS", "60"))


def get_content() -> bytes:
    """監視対象 URL の内容を取得する"""
    response = requests.get(URL, timeout=10)
    response.raise_for_status()
    return response.content


def notify_slack(message: str) -> None:
    """Slack にメッセージを送信する"""
    if not SLACK_API_TOKEN:
        print("SLACK_API_TOKEN が設定されていないため、Slack 通知をスキップします。")
        return

    client = WebClient(token=SLACK_API_TOKEN)
    try:
        client.chat_postMessage(channel=SLACK_CHANNEL, text=message)
        print(f"Slack に通知しました: {message}")
    except SlackApiError as e:
        error = e.response.get("error", str(e))
        print(f"Slack 通知に失敗しました: {error}")


def main() -> None:
    previous_content: bytes | None = None

    print(f"Monitoring {URL} (interval: {CHECK_INTERVAL_SECONDS} seconds)")
    while True:
        try:
            current_content = get_content()

            if previous_content is None:
                previous_content = current_content
                print("初回取得完了。以降は変更があったときのみ通知します。")
            elif current_content != previous_content:
                notify_slack("The site has been updated!")
                previous_content = current_content
        except Exception as e:
            print(f"チェック中にエラーが発生しました: {e}")

        time.sleep(CHECK_INTERVAL_SECONDS)


if __name__ == "__main__":
    main()
