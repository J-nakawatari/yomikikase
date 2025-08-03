# Yomikikase（読み聞かせ）

子ども向けの読み聞かせWebサービス。キーワードを3つ入力すると、AIが物語を自動生成し、音声で読み上げます。

## 🎯 特徴

- 📱 スマートフォン最適化（縦向きUI）
- 🎨 絵本風の優しいデザイン
- 🤖 AI（GPT-4/Claude）による物語生成
- 🔊 自動音声読み上げ（Google TTS/ElevenLabs）
- 🔄 複数話の生成機能

## 🚀 クイックスタート

### 前提条件

- Docker & Docker Compose
- Node.js 20+（ローカル開発時）

### セットアップ

1. リポジトリをクローン
```bash
git clone https://github.com/J-nakawatari/yomikikase.git
cd yomikikase
```

2. 環境変数を設定
```bash
cp .env.example .env
# .envファイルを編集してAPIキーを設定
```

3. Docker環境を起動
```bash
make install  # 初回のみ
make up       # コンテナ起動
```

4. ブラウザでアクセス
```
http://localhost:3005
```

## 📦 技術スタック

### フロントエンド
- Next.js (TypeScript)
- Tailwind CSS
- React Icons

### バックエンド
- Express.js (Node.js)
- OpenAI/Claude API
- Google Cloud TTS/ElevenLabs

### インフラ
- Docker & Docker Compose
- PostgreSQL
- Redis

## 🛠️ 開発

### 開発用コマンド

```bash
# コンテナ操作
make up       # 起動
make down     # 停止
make logs     # ログ確認
make shell    # コンテナ内シェル

# 開発
npm run dev   # 開発サーバー起動（ローカル）
```

### ポート設定

- フロントエンド: 3005
- バックエンドAPI: 4005
- MCPサーバー: 4006

## 📝 ライセンス

MIT