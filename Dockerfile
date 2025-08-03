# Node.js 20のベースイメージを使用
FROM node:20-slim

# 作業ディレクトリの設定
WORKDIR /app

# 必要なシステムパッケージをインストール
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# package.jsonとpackage-lock.json（存在する場合）をコピー
COPY package*.json ./

# 依存関係のインストール
RUN npm ci || npm install

# アプリケーションのソースコードをコピー
COPY . .

# MCP設定ディレクトリの作成
RUN mkdir -p /app/.mcp

# ポート3005を公開（フロントエンド用）
EXPOSE 3005

# 開発サーバーの起動
CMD ["npm", "run", "dev"]