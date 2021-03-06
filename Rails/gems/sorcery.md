## sorceryを使ってのlogin・logout機能の実装

・参考記事
https://qiita.com/tanutanu/items/52ceab22ad21ba97c902

・テーブル設計
要件
    ログインログアウト機能がある
    ユーザーはニックネームとアバター画像を登録できる
Usersテーブル
    username:string:null false
    email:string:null false

・コントローラー設計
ユーザー登録画面を表示  get     /users/new  user#new
ユーザー登録をする      post    /users      users#create
ログイン画面を表示する  get     /login      sessions#new
ログインする            post    /login      sessions#create
ログアウトする          delete  /login      sessions#destroy

・なぜdeviceではなくsorceryなのか？
deviceのメリットはボタン一つでviewまで作成してくれること。一方sorceryのメリットはシンプルだからカスタムしやすいところ。
一度deviceを使用したことがあるが一気に色んなものが作成されるため手に負えないように感じた。自分にわかる範囲のことを実装するためにはsorceryが向いていると判断した。

### 開発手順
1, gemのインストール
gemfileにsorceryを追加してbundle installを行った。
以下のメッセージが表示されたがoauth1と2でどちらが安全なのかは議論されてるようなので無視して進めてok.
As of version 1.0 oauth/oauth2 wont be automatically bundled so you may need to add those dependencies to your Gemfile.
You may need oauth2 if you use external providers such as any of these: https://github.com/Sorcery/sorcery/tree/master/lib/sorcery/providers

2, bundle exec rails generate sorcery:installで以下のmigrationファイルを作成。

```ruby
db\migrate\20211219030514_sorcery_core.rb
def change
  create_table :users do |t|
    t.string :email,            null: false, index: { unique: true }
    t.string :crypted_password
    t.string :salt
    t.timestamps                null: false
  end
end
```

3, ユーザー名を追加してbundle db:migrateでテーブル作成。

```ruby
create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    # 標準で生成されるマイグレーションファイルのは上のものになる。saltカラムはパスワードの暗号化のためのものである。
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end
```

4, bundle exec rails g controller Users new createで新規登録のためのコントローラーを作成する。

5, routesの設定
```ruby
  root 'users#new'
  resources :users, only: [:new, :create]
```

6, app\views\users\new.html.slimでviewのコードを追加する。
```ruby
= form_with model: @user, local: true do |f|
  = f.label :email
  = f.text_field :email
  = f.label :password
  = f.password_field :password
  = f.label :password_confirmation
  = f.password_field :password_confirmation
  = f.submit "登録"
```

7, コントローラーでnewとcreateアクションの設定を行う。
```ruby
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
      flash[:notice] = 'ユーザーの作成に成功しました'
    else
      flash.now[:alert] = 'ユーザーの作成に失敗しました'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
```

8, Modelでvalidation設定とpasswordやpassword_confirmationにcrypted_passwordを結びつける。
```ruby
class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # comfirmationについて
  # このヘルパーは、2つのテキストフィールドで受け取る内容が完全に一致する必要がある場合に使います。たとえば、メールアドレスやパスワードで、確認フィールドを使うとします。このバリデーションヘルパーは仮想の属性を作成します。属性の名前は、確認したい属性名に「_confirmation」を追加したものになります。
  # presenceについて
  # このヘルパーは、指定された属性が「空でない」ことを確認します。値がnilや空文字でない(つまり空欄でもなければホワイトスペースでもない)ことを確認するために、内部でblank?メソッドを使っています。
  # 1, new_record?でObjectが新規だった場合はvalidationが実行される。
  # そうでない場合はchanges[:crypted_password]がtrueかfalseかの処理が行われる。
  # 2, changes[:crypted_password]がtrue(パスワードが変更された)の場合はvalidationが実行される。
  # 3, どちらもfalseだった場合validationは実行されることなくパスワード入力が省略される。
  validates :email, uniqueness: true
end
```
以上でユーザー登録に関する機能は完了。

9, ユーザー登録が問題なく行えるか確認
・rails cでUser.createを実行。
```ruby
User.create!(username: "test", email: "te@email.com", password: "test12345", password_confirmation: "test12345")
  (4.1ms)  BEGIN
  User Exists (8.6ms)  SELECT  1 AS one FROM `users` WHERE `users`.`email` = BINARY 'test@email.com' LIMIT 1
  User Create (7.3ms)  INSERT INTO `users` (`email`, `crypted_password`, `salt`, `username`, `created_at`, `updated_at`) VALUES ('test@email.com', '$2a$10$4vSZABlewF5jlWYaYpY4IeydEwdA9iI.NmFdZuPgQW1W3wjIhY7dm', '5J6CMm6PhbETq5PSNJ-p', 'test', '2021-12-21 19:55:02', '2021-12-21 19:55:02')
```

・User.allで確認すると無事にユーザーが登録されている。
```
=>   User Load (0.4ms)  SELECT `users`.* FROM `users`
[#<User:0x000000000a7f95e0
  id: 1,
  email: "test@email.com",
  crypted_password: "$2a$10$4vSZABlewF5jlWYaYpY4IeydEwdA9iI.NmFdZuPgQW1W3wjIhY7dm",
  salt: "5J6CMm6PhbETq5PSNJ-p",
  username: "test",
  created_at: Tue, 21 Dec 2021 19:55:02 JST +09:00,
  updated_at: Tue, 21 Dec 2021 19:55:02 JST +09:00>]
```

10, login,logout機能を設定するためにUserSessionsコントローラーを作成する。
コマンドで以下を実行
rails g controller UserSessions new create destroy

11, コントローラーに以下のコードを追加
```ruby
app/controllers/user_sessions_controller.rb
  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to(new_user_path, notice: 'ログインに成功しました')
      # フレンドリーフォワーディング
      # 保護されたページにアクセスしようとすると、問答無用で自分のプロファイルページに移動させられてしまいます。
      # 別の言い方をすれば、ログオンしていないユーザーが編集ページにアクセスしようとしていたなら、ユーザーがサインインした後にはその編集ページにリダイレクトされるようにするのが望ましい動作です。
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(login_path, notice: 'ログアウトしました')
  end
```

12, routesで以下のように設定を変更する。
```ruby
  get 'login', to: 'user_sessions#new'  
  post 'login', to: 'user_sessions#create'  
  delete 'logout', to: 'user_sessions#destroy' 
```

13, viewを追加する。