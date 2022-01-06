## 全体を通しての感想
・他の方のアウトプットを見てみると自分と似たところで詰まっている人が多かった。
そこから解決策なども見れるのでこの課題でも他の人の回答見ることは大切だなと思いました。

### エラー・詰まったところ

### Rubyのバージョン指定(windows)
#### 詰まった原因
Macの場合だとrbenvというgemで簡単にバージョン変更を行えるみたいだが、rbenvをwindowsで使うのが難しすぎて詰まった。
rbenvを使うためにubuntuをダウンロードしなければならないなど知らない単語ばかりが出てきてrbenvはギブアップしてしまった。

#### 解決方法
windowsには専用のrubyバージョン管理システムuru(https://techacademy.jp/magazine/18732)があったのでこれを導入。
設定方法も以下の３ステップで簡単にできた。
> 1, https://bitbucket.org/jonforums/uru/wiki/Downloads からバイナリをダウンロードする
> 2, 解凍するとuru_rt.exeというファイルが現れるので、環境変数 PATHの通った適切なディレクトリに配置
> 3, 以下のコマンドを実行してインストール完了

##### 感想
・無理にMacのやり方でやろうとするのではなく自分のPCに合った方法を選択するべきだった。
・設定方法の「環境変数 PATHの通った適切なディレクトリに配置」の部分がよくわからなかった。
特にいじることなく設定できたが環境変数とpathについてはもう少し理解しといたほうが良さそう。

### pull requestで大量のfiles changedが出てしまう。
#### 詰まった原因
課題１の終了後にpull requestを作ってみると差分が5000以上になってしまっていた。
この問題は他の方もよく遭遇していた。原因はvendor/bundleをgitignoreに登録していなかったことだった。
・bundle install --path vendor/bundleとは
gemをアプリケーション毎に管理したい時に使われるコマンドである。これによって導入されるgemがアプリケーションディレクトリ内に保存されます。
１度このコマンドを実行すると解除するまでgemはvendor/bundleに保存される。
しかし、.gitignoreに追加ていないと大量のファイルがすべてgitで管理されてしまうため今回のような問題が発生してしまった。

#### 解決策
・根本的な解決としてはrails newした後にgit add .する前に.gitignoreファイルにvender/boundelrを記入すること。
他にも.gitigonoreに登録しておいた方がいいものもある。
```
.gitignoer
/config/database.yml
#登録しないとdatabaseのパスワードが公開されてしまうのでrails new後に.gitignoreするべき。
vendor/bundle
#今回のケース
/public/uploads
#画像投稿機能を使う場合はこれも登録する。じゃないと投稿された画像がすべてgitで管理されることになり大量の差分が生まれる。
```

・試してみたこと
git rm vendor/bundle --cachedを実行すると後からでもgitの対象外とすることができるみたいなので実行。
ただ自分の場合は↓で話されてるように削除いた分の差が表示されてしまうため結局差分を減らすことはできなかった。
https://tech-essentials.work/courses/11/tasks/9/outputs/792
なので、諦めて新しくアプリを作り直しで対応することにした。

### BMDの導入
#### 詰まった原因
↓で質問させてもらったようにバージョンの異なる記事(https://qiita.com/sasakura_870/items/38e17d95d9497cf81413)を参考に導入したので詰まりました。
https://tech-essentials.work/questions/441

#### 解決策
現場railsの268ページの内容を参考にすると回答例の導入原理がよく分かったのでまとめる。

1, yarnをインストールする。
yarn add bootstrap-material-design

2, gemのインストール
```
gem 'font-awesome-sass', '~> 5.4.1'
gem 'jquery-rails'
gem 'popper_js'
BootstrapはjQueryに依存するため、(デフォルトでjQueryがインストールされない)Rails5.1以上ではjquery-railsもGemfileに追記する
```

3, application.html.erbで以下のコードが記入されていることを確認する。
cssやJavaScriptなどのアセットはweb画面にアクセスしたブラウザがサーバーから返されたHTML内にある
scriptタグ、linkタグなどの情報を読み取ることで利用できる。
```
app\views\layouts\application.html.erb
<%= stylesheet_link_tag    'application', media: 'all' %>
# cssを読み込むためのリンク application.cssを読み込んでくれる
<%= javascript_include_tag 'application' %>
# JavaScriptを読み込むためのリンク application.jsを読み込んでくれる
```

4, ファイルの出力方法をマニフェストファイル(application.cssやapplication.jsのこと)に書き込む。
指定されたファイルはアセットの探索パスを基に引き当てられ、読み込まれる。

Bootstrap導入のためにはおそらくデフォルトのapplication.cssをapplication.scssに変更する必要がある。
```
app\assets\stylesheets\application.scss
@import 'bootstrap-material-design/dist/css/bootstrap-material-design';
# 読み込みたいファイルを@importする。
@import 'font-awesome-sprockets';
@import 'font-awesome';
```

5, application.jsで読み込むJSファイルを指定する。
```
app\assets\javascripts\application.js
//
//= require popper
//= require jquery3
# requireは指定したJavaScripファイルの内容を記述した位置に読み込む。
//= require rails-ujs
# Railsの一部のRESTfulな動作や非同期な処理などを実現するために、JavaScriptの送信に関する処理などが書かれたライブラリ
# https://www.inodev.jp/entry/2019/12/03/234210
//= require activestorage
//= require_tree .
# require_tree .はrails-ujsとjquery3の下に書かないとjqueryが読み込まれなくなる(https://qiita.com/sasakura_870/items/968f273dcb9ea0fdb063)
//= require bootstrap-material-design/dist/js/bootstrap-material-design.js
```

#### 感想
・JSが絡んでくるとわけわからなくなるので苦手意識があったが原理を考えると理解できた。
webブラウザにJSやCSSを反映するためにはhtmlファイルにリンクを記述→JS,CSSそれぞれのファイルでどう結合,出力するかを記述。


### headerについて（これは詰まりではなく勉強になった話
#### メモ
へッダーに表示する内容について深く考えたことがなかったので勉強になった。
表示させる要素は以下の４つ。エラーメッセージとフラッシュメッセージの違いもここで理解できた。
・エラーメッセージ
・flashメッセージ
・ログイン前のヘッダー
・ログイン後のヘッダー

#### 導入
2, app\views\sharedフォルダーを作成してそれぞれのテンプレートファイルを作成する。
この時、_header.html.slimのようにファイル名の前に_を付けるようにする。

3, \app\views\layouts\application.html.slimで以下のようなif文を書くことによって表示させる内容を変更させる。
```
body
    - if logged_in?
      = render 'shared/header'  #ログイン後のヘッダー
    - else
      = render 'shared/before_login_header' #ログイン前のヘッダー
    = render 'shared/flash_messages'    #flashメッセージ
    = yield
```

4, エラーメッセージの表示方法について
ここでのエラーメッセージとは「モデルのvaridationに違反しているときにメッセージを表示してくれる」もの。
app\views\shared\_error_messages.html.slimにおいて以下のコードを追記する。
```
- if object.errors.any?
  #error_messages.alert.alert-danger
    ul.mb-0
      - object.errors.full_messages.each do |msg|
        li = msg
```
app\views\users\new.html.slimにrenderで追記する。
```
= form_with model: @user, class: 'card-body', local: true do |f|
        = render 'shared/error_messages', object: @user
        .form-group
          = f.label :username, class: 'bmd-label-floating'
          = f.text_field :username, class: 'form-control'
        .form-group
          = f.label :email, class: 'bmd-label-floating'
          = f.email_field :email, class: 'form-control'
        .form-group
          = f.label :password, class: 'bmd-label-floating'
          = f.password_field :password, class: 'form-control'
        .form-group
          = f.label :password_confirmation, class: 'bmd-label-floating'
          = f.password_field :password_confirmation, class: 'form-control'

        = f.submit '登録', class: 'btn btn-raised btn-primary'
```
これで対象のモデルのdaridationに違反した場合に違反メッセージが表示させるようになる。
参考記事:https://qiita.com/ryuuuuuuuuuu/items/1a1e53d062bff774d88a

5, flashメッセージの表示方法について
app\views\shared\_flash_messages.html.slimで以下のコードを追記する。これで表示領域が確保できる。
```
- flash.each do |message_type, message|
  div class=("alert alert-#{message_type}") = message
```
contorollerにおいて以下のようにコードを書くことでflashメッセージを表示することができる。
flash→次のアクションまでデータを保持する→redirect_toと一緒に使う
flash.now→次のアクションに移行した時点でデータが消える→renderと一緒に使う
```
def create
  @user = User.new(user_params)
  if @user.save
    auto_login(@user)
    redirect_to login_path, success: 'ユーザーを作成しました'
  else
    flash.now[:danger] = 'ユーザーの作成に失敗しました'
    render :new
  end
end
```
参考記事:https://qiita.com/d0ne1s/items/2eccf6b22e7ed1d25925

6, ログイン後とログイン前のヘッダーの使い分け
以下のコードのように使える機能によって分けて挙げるとよい。
```
#ログイン前
ul.navbar-nav.mt-2.mt-lg-0
  li.nav-item
    = link_to 'ポスト一覧', '#', class: 'nav-link'
  li.nav-item
    = link_to 'ログイン', login_path, class: 'nav-link'

#ログイン後
ul.navbar-nav.mt-2.mt-lg-0
  li.nav-item
    a.nav-link href="#"
      = icon 'far', 'image', class: 'fa-lg'
  li.nav-item
    a.nav-link href="#"
      = icon 'far', 'heart', class: 'fa-lg'
  li.nav-item
    a.nav-link href="#"
      = icon 'far', 'user', class: 'fa-lg'
  li.nav-item
    = link_to 'ログアウト', logout_path, class: 'nav-link', method: :delete
```