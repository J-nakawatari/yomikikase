# Makefile - Docker開発環境の管理用

.PHONY: help build up down restart logs shell clean install

# デフォルトコマンド（ヘルプを表示）
help:
	@echo "使用可能なコマンド:"
	@echo "  make build    - Dockerイメージをビルド"
	@echo "  make up       - コンテナを起動"
	@echo "  make down     - コンテナを停止・削除"
	@echo "  make restart  - コンテナを再起動"
	@echo "  make logs     - ログを表示"
	@echo "  make shell    - アプリコンテナにシェルで接続"
	@echo "  make clean    - ボリューム含めて完全削除"
	@echo "  make install  - 初回セットアップ"

# Dockerイメージのビルド
build:
	docker-compose build

# コンテナの起動
up:
	docker-compose up -d

# コンテナの停止・削除
down:
	docker-compose down

# コンテナの再起動
restart: down up

# ログの表示
logs:
	docker-compose logs -f

# アプリコンテナにシェル接続
shell:
	docker-compose exec app /bin/bash

# 完全クリーンアップ
clean:
	docker-compose down -v
	docker system prune -f

# 初回セットアップ
install: build
	@echo "初回セットアップを実行中..."
	docker-compose run --rm app npm install
	@echo "セットアップ完了！'make up'でコンテナを起動してください。"