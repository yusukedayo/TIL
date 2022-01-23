## 他の人のコードをローカル環境で動かす手順
### 前提
ローカル環境で動かすために必要なことはプロジェクトによって異なる。
基本はread.meの内容に従えばおk。ここではそれぞれの動作を行う必要性について述べる。

### 実装手順
・git clone https://github.com/miketa-webprgr/instagram_clone.git
・git checkout git checkout -b feature/01_login_logout origin/feature/01_login_logout
・bundle install
ここでbundle updateが必要な時もある。うまくinstallできない場合はupdateしよう
・yarn install
インスタクローンの場合はBMDの導入とかをyarnで行っていたのでこれを行わないとエラーが発生する。
・MySQL と Redis を立ち上げる
MySQLを立ち上げる際はdatabese.ymlのパスワードを自分のように変更する必要がある。
databese.ymlを新しく自分で追加した場合はdatabaseの名前が既存の物と被っていないかcheckする。
・rails db:create
このアプリでのデータベースを構築する。
・rails db:migrate
・rails db:seed