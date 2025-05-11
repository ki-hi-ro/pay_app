#!/bin/bash
set -e

# Rails サーバーがすでに起動している場合の pid ファイルを削除
rm -f /rails/tmp/pids/server.pid

# 受け取ったコマンドを実行（例: rails server）
exec "$@"