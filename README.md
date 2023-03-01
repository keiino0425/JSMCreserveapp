# JSMC予約管理アプリ
 JSMCというヘッドスパスクールの予約管理をするサイトです。<br >
 イメージとしては美容室などの予約アプリのようなシステムです。<br >
 まず教師側が授業可能な日程を登録し、その日程の中から生徒が日程を選択し、授業を予約するという使い方です。
 <img width="1440" alt="生徒のマイページ" src="https://user-images.githubusercontent.com/83698071/221013932-49a413e3-bc01-4cdb-b69c-7ffcf6b60274.png">
<img width="1440" alt="生徒の仮予約画面" src="https://user-images.githubusercontent.com/83698071/221014047-b8303f7f-52a0-4f89-adc5-9373ab0e2f87.png">

# URL
https://jsmc-machido.com/ <br >
ゲストログイン機能は作成中です。

# 使用技術
- Ruby 2.7.5
- Ruby on Rails 6.1.6.1
- MySQL
- mySQL
- Docker
- Heroku
- AWS(S3)
- CircleCI
- RSpec(導入途中)

# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 仮予約、予約機能(simple_calendar)
  - 自動メール送信機能(Action mailer)

# テスト
- rspec
 - 単体テスト(Model)
 - 統合テスト(System)
