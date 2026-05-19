# README
# ピザの王国 Online

Ruby on Railsで開発したピザ注文システムです。
大学のWebシステム開発課題として作成しました。
商品注文、会員管理、注文管理などの機能を実装しています。

## 使用技術

- Ruby 3.1.6p260
- Ruby on Rails 7.0.10
- SQLite3
- HTML / CSS
- Git
- docker

## 主な機能

- 会員登録 / ログイン
- 商品一覧表示
- 商品注文
- 注文履歴表示
- 在庫管理

## 工夫した点

注文と商品の関係を適切に管理するため、
OrderモデルとItemモデルの間に
Detailモデルを導入しました。

これにより、
「どの商品を何個注文したか」を
管理できる構造に改善しました。

## 実行方法

まず以下コードからdockerfileを作成します。

```
FROM ruby:3.1.6-bullseye

ENV LANG="C.UTF-8" \
    TZ="Asia/Tokyo" \
    RAILS_VERSION="7.0.4"

RUN apt-get update && apt-get install -y vim git less && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y sqlite3 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get -y install build-essential && rm -rf /var/lib/apt/lists/*

RUN gem install concurrent-ruby --version 1.3.4 -N

RUN gem install rails --version "$RAILS_VERSION" -N

RUN gem update bundler

ENV RUBYOPT="-rlogger"

RUN git config --global init.defaultBranch main

EXPOSE 3000
```
次に以下のコマンドを実行します。

```bash
git clone https://github.com/anmitsu-bot/my-rails.git
cd my-rails

docker build -t my-rails .

docker run -d --name rails25 -p 3000:3000 my-rails

docker exec -it rails25 bash

cd ./my-rails

bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
bin/rails s -b 0.0.0.0
```

その後ブラウザで以下のポート番号にアクセス
http://localhost:3000

