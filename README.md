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

```bash
git clone https://github.com/anmitsu-bot/my-rails.git
cd my-rails
bundle install
rails db:migrate
rails s -b 0.0.0.0
```

その後ブラウザで以下のポート番号にアクセス
http://localhost:3000

