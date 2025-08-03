# CLAUDE.md - Yomikikase プロジェクト設定

このファイルはYomikikaseプロジェクト固有の設定とガイドラインです。

最終更新: 2025-01-08

## プロジェクト概要

**Yomikikase（読み聞かせ）** は、子ども向けの読み聞かせWebサービスです。ユーザーがキーワードを3つ入力すると、AI（OpenAI GPT-4またはClaude API）が子ども向けの物語を自動生成し、音声合成（Google Cloud TTSまたはElevenLabs）により読み上げを行います。

### 主な特徴
- **対象**: 子どもとその保護者
- **デバイス**: スマートフォン最適化（縦向きUI）
- **デザイン**: 絵本風の優しいインターフェース
- **機能**: 
  - キーワード3つから物語を自動生成
  - 自動音声読み上げ（停止・再生制御可能）
  - 複数話の生成機能

## ポート設定

### 本番環境
- フロントエンド (Next.js/React): **3005**
- バックエンド (Express/Node.js): **4005**
- MCPサーバー: **4006**
- PostgreSQL: 5432 (Dockerコンテナ内)
- Redis: 6379 (Dockerコンテナ内)

### 開発環境（Docker）
- フロントエンド: 3005 (ホスト) → 3005 (コンテナ)
- バックエンド: 4005 (ホスト) → 4005 (コンテナ)
- MCPサーバー: 4006 (ホスト) → 4006 (コンテナ)

**注意**: 他のプロジェクトで使用されているポート
- 3000-3004: 他サービスで使用中
- 4000-4004: 他サービスで使用中
- 5000-5199: Charactier AI関連
- 6379: Redis（共有）
- 27017, 27020: MongoDB

## 開発コマンド

### Docker環境
```bash
# 初回セットアップ
make install

# コンテナ起動
make up

# ログ確認
make logs

# コンテナ内でシェル実行
make shell

# 再起動
make restart

# 完全クリーンアップ
make clean
```

### 直接実行（Docker外）
```bash
# 依存関係インストール
npm install

# 開発サーバー起動
npm run dev

# MCPサーバー起動
npm run mcp:server
```

## アーキテクチャ

### フロントエンド
- **フレームワーク**: Next.js (TypeScript)
- **スタイリング**: Tailwind CSS
- **UIライブラリ**: React Icons / Heroicons
- **ポート**: 3005
- **APIエンドポイント**: http://localhost:4005/api
- **特徴**: 
  - スマホ最適化（縦向きUI、片手操作想定）
  - 絵本風の優しいデザイン
  - 淡い色調の背景

### バックエンド
- **フレームワーク**: Express.js (Node.js)
- **ポート**: 4005
- **APIルート**: `/api/v1/*`
- **外部API統合**:
  - OpenAI GPT-4 API または Claude API（物語生成）
  - Google Cloud Text-to-Speech または ElevenLabs（音声合成）
- **主要エンドポイント**:
  - `POST /api/v1/story/generate` - 物語生成
  - `POST /api/v1/audio/synthesize` - 音声合成

### MCPサーバー
- **ポート**: 4006
- **設定ファイル**: `/mcp-config/claude_desktop_config.json`
- **対応サーバー**:
  - filesystem
  - memory
  - github (要トークン設定)
  - postgres

## 環境変数

`.env`ファイルを作成（`.env.example`を参考）:

```env
NODE_ENV=development
PORT=3005
API_PORT=4005
MCP_SERVER_PORT=4006

# データベース
DB_HOST=localhost
DB_PORT=5432
DB_NAME=yomikikase
DB_USER=yomikikase
DB_PASSWORD=yomikikase_dev_password

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379

# AI API設定
OPENAI_API_KEY=your_openai_api_key_here
ANTHROPIC_API_KEY=your_claude_api_key_here

# 音声合成API設定
GOOGLE_CLOUD_TTS_KEY=your_google_tts_key_here
ELEVENLABS_API_KEY=your_elevenlabs_key_here

# GitHub（MCP連携用）
GITHUB_PERSONAL_ACCESS_TOKEN=your_token_here
```

## デプロイメント（将来用）

### PM2プロセス名（予約）
- `yomikikase-frontend`
- `yomikikase-backend`
- `yomikikase-mcp`

### Nginxサイト設定（予約）
- `/etc/nginx/sites-available/yomikikase`

## セキュリティ考慮事項

- 環境変数でセンシティブな情報を管理
- CORS設定でAPIアクセスを制限
- JWTトークンによる認証（実装時）
- CSRFトークン保護（実装時）

## ユーザー操作フロー

1. **トップページ**: キーワード入力フォーム（3つの入力欄）
2. **物語生成**: 送信ボタンクリックで物語が自動生成・表示
3. **音声再生**: 物語表示と同時に自動で音声読み上げ開始
4. **再生制御**: 一時停止・再生・停止ボタンで音声制御可能
5. **追加生成**: 「もう1話」ボタンで新しい物語を生成可能

## 主要コンポーネント

### フロントエンド
- `KeywordForm.tsx` - キーワード入力フォーム
- `StoryDisplay.tsx` - 物語表示エリア
- `AudioPlayer.tsx` - 音声再生コントロール
- `Layout.tsx` - 絵本風レイアウト

### バックエンド
- `routes/story.js` - 物語生成API
- `routes/audio.js` - 音声合成API
- `services/ai.js` - AI API統合サービス
- `services/tts.js` - 音声合成サービス

## 注意事項

- このプロジェクトはDocker環境での開発を前提としています
- ポート番号は他のプロジェクトと重複しないよう注意してください
- MCPサーバーの設定は`mcp-config`ディレクトリで管理します
- API使用量に注意（特に音声合成API）
- 子ども向けコンテンツのため、生成される物語の内容に配慮が必要