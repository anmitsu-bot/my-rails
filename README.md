# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
ruby 3.1.6p260 (2024-05-29 revision a777087be6) [aarch64-linux]

* System dependencies
rails:/var/www root# apt-cache depends rails
rails
  Depends: ruby-rails
  Depends: bundler
  Depends: puma
  Depends: ruby-bootsnap
  Depends: ruby-byebug
  Depends: ruby-capybara
  Depends: ruby-jbuilder
  Depends: ruby-listen
  Depends: ruby-sass-rails
  Depends: ruby-selenium-webdriver
  Depends: ruby-spring
  Depends: ruby-spring-watcher-listen
  Depends: ruby-sqlite3
  Depends: ruby-turbolinks
  Depends: ruby-uglifier
  Depends: ruby-web-console
  Depends: ruby-webpacker
  Recommends: yarnpkg
  
* Configuration
PATH=/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=39bb0e2c90b3
TERM=xterm
LANG=C.UTF-8
RUBY_VERSION=3.1.6
RUBY_DOWNLOAD_URL=https://cache.ruby-lang.org/pub/ruby/3.1/ruby-3.1.6.tar.xz
RUBY_DOWNLOAD_SHA256=597bd1849f252d8a6863cb5d38014ac54152b508c36dca156f6356a9e63c6102
GEM_HOME=/usr/local/bundle
BUNDLE_SILENCE_ROOT_WARNING=1
BUNDLE_APP_CONFIG=/usr/local/bundle
TZ=Asia/Tokyo
RAILS_VERSION=7.0.4
RUBYOPT=-rlogger
HOME=/root

* Database creation
データベースの作成方法について
まず前提としてデータベースはSQLite3を使用しています。
database.ymlの設定に従って以下のコマンドを実行します。
bin/rails db:create

次に以下のコマンドでモデルを作成します。
bin/rails g model <member>

その後マイグレーションスクリプトにモデルのカラムと型の宣言のコードを記述してbin/rails db:migrateを実行する
以下は参考までにmemberモデルのマイグレーションスクリプトである。
class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
     t.string :name, null: false #ユーザー名
     t.integer :point #ポイント残高
     t.integer :role, null: false, default: 1 #役割 (1:顧客, 2:店員, 3:管理者)
     t.string :password_digest #パスワード
     t.timestamps
    end
  end
end

マイグレーションが完了したらschema.rbを確認して意図した形でモデルが入っているか確認する
以下はスキーマでのmemberモデルの中身である
  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.integer "point"
    t.integer "role", default: 1, null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

* Database initialization
モデルを作成するとseed.rbというファイルができます。そこに以下のコードを記述します。
table_names = %w(essential)
table_names.each do |table_name|
    path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
    if File.exist?(path)
        puts "Creating #{table_name}"
        require path
    end
end

これを保存すると以下のコマンドでシードデータを入れられるようになります。
bin/rails db:seed

シードデータを再投入したい際は以下のコマンドを使用し、再投入を行なってください
bin/rails db:migrate:reset db:seed

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
このプロジェクトは架空のピザ店「ピザの王国」のオンライン予約システム「PIZZAON」として開発されました。
このプロジェクトで実際にピザ販売をやろうとしていたわけではなく予約システムを作ってみることでミドルウェア関連の知識を身につけることが目的でした。

* Deployment instructions
dockerfile　の中身は以下の通りです
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


このDockerfileを用いて以下のコマンドでビルドを行った
docker build -t ns-rails:2025 .
dockerデスクトップか以下のコマンドでコンテナを起動する
docker run -p 3000:3000 -v $(pwd)/rails:/var/www -w /var/www --name rails25 -d ns-rails:2025 tail -f /dev/null
あとは以下のコマンドでコンテナへのログイン、ログアウトを行う
docker exec -it rails25 bash　#ログイン用コマンド
exit　#ログアウト用コマンド

* ...
