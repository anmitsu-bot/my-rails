# ピザの王国 Online

Ruby on Railsで開発したピザ注文システムです。  
大学のWebシステム開発課題として作成しました。  
商品注文、会員管理、注文管理などの機能を実装しています。

---

## 使用技術

- Ruby 3.1.6
- Ruby on Rails 7.0.10
- PostgreSQL
- HTML / CSS
- Git / GitHub
- Docker
- Docker Compose

---

## 主な機能

- 会員登録 / ログイン
- 商品一覧表示
- 商品注文
- 注文履歴表示
- 在庫管理

---

## 工夫した点

注文と商品の関係を適切に管理するため、  
OrderモデルとItemモデルの間に  
Detailモデルを導入しました。

これにより、

- 「どの商品を」
- 「何個注文したか」

を管理できる構造に改善しました。

---

##　アーキテクチャ
### ER図
./erd.png

## 開発環境構築

### リポジトリをclone

```bash
git clone https://github.com/anmitsu-bot/my-rails.git
cd my-rails
```
### コンテナ起動
```bash
docker compose up --build
```
### データベース作成
コンテナ起動後、別ターミナルで実行：
```bash
docker compose exec web rails db:create
docker compose exec web rails db:migrate
docker compose exec web rails db:seed
```
### アクセス方法
ブラウザで以下へアクセス：
http://localhost:3000

### Dockerfile
```
FROM ruby:3.1.6-bullseye
ENV LANG="C.UTF-8" \
    TZ="Asia/Tokyo" \
    RAILS_VERSION="7.0.4"
RUN apt-get update && apt-get install -y vim git less && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get -y install build-essential && rm -rf /var/lib/apt/lists/*
RUN gem install concurrent-ruby --version 1.3.4 -N
RUN gem install rails --version "$RAILS_VERSION" -N
RUN gem update bundler
ENV RUBYOPT="-rlogger"
RUN git config --global init.defaultBranch main
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install
COPY . /app
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
```
### docker-compose.yml
```
version: '3'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
```
