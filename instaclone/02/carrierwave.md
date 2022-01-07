## carrierwaveで画像投稿機能を実行
- - -
・参考記事
https://pikawaka.com/rails/carrierwave
https://github.com/miketa-webprgr/TIL/blob/master/11_Rails_Intensive_Training/02_issue_note_carrierwave.md

### 手順
1, gemをインストールしてbundle installを行う。
```gemlife
gem 'carrierwave', '~> 2.0'
```

2, アップローダークラスを生成する。
ターミナルでbundle exec rails g uploader アップローダー名を実行する。
これによってapp/uploaders/アップローダー名_uploader.rbファイルが作成される。
ここではアップロードするファイルの拡張子やサイズ、保存するパスを指定する事が出来る。
(この部分はみけたさんのメモをコピペさせてもらってます。詳しくはhttps://github.com/miketa-webprgr/TIL/blob/master/11_Rails_Intensive_Training/02_issue_note_carrierwave.md)
```ruby
class PostImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # 今回はMiniMagickが採用されている
  # 使う場合、HomebrewなどでImagaMagickをインストールすること
  include CarrierWave::MiniMagick

  # resize_to_fit(): そのサイズに合うようにリサイズ。（大きくなることがある。）
  # resize_to_limit(): そのサイズより大きい画像のときに、そのサイズに合うようにリサイズ。（大きくなることはない。）
  process resize_to_limit: [1000, 1000]

  # Choose what kind of storage to use for this uploader:
  # なお、storage :fogは、本番環境でクラウドストレージを活用する場合に使用する
  storage :file

  # 保存先はここで指定する
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # ファイルがアップロードされていない場合、デフォルトのアップロード先URLを設定する
  # ・・・何に使うんだろう？
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # これを設定すると、アップロードする過程でファイルをリサイズしてくれるらしい
  # つまり、carrierwaveにおいては、ファイル自体はデフォルトのサイズでアップロードするが、表示する段階においてリサイズしている
  # それだとサイズの大きいファイルがサーバーにアップロードされて困る！っていう人はここで設定しろ、ということだと思う
  # https://github.com/carrierwaveuploader/carrierwave#adding-versions
  # 今回は不要なので、特に設定されていない
  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end


  # 設定すると、普通のファイル＋サムネ用のファイルの2つがアップロードされるらしい
  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # ホワイトリスト。拡張子でアップロードできるファイルを制限している
  # モデルでバリデーションをかけるのも忘れないように！
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # ファイル名の設定。モデルidを名前に使うなと書いてある。。。
  # 真面目なので、ちゃんとuploader/store.rbを読んでみた！！！
  # https://github.com/carrierwaveuploader/carrierwave/blob/master/lib/carrierwave/uploader/store.rb
  # コードの解読はスルーしたが、DBに保存する時に、record id will be nil と書いてあった

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
```
3, アップロード画像の情報を保存するカラムを指定のテーブルに追加する。データはstring型になる。
bundle exec rails g migration add_avatar_to_users avatar:stringでmigrationファイルを作りbundle exec rails db:migrateする。

4, controllerでparamsに3で作ったカラムを追加する。
```ruby
def user_params
  params.require(:user).permit(:nickname, :age, :avatar) # 変更後
end
```

5, 画像投稿を行いたいモデルにavatarカラム(画像保存用)とAvatarUplodarクラスを紐づける。
これによって画像アップロードの際にAvatarUplodarクラスの設定を利用できるようになる。
```
class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
end
```

6, 画像を投稿するためにviewのnewファイルを変更する。
```ruby
<div class="field">
  <%= form.label :avatar %>
  <%= form.file_field :avatar %>
</div>
```

7, upload先を.gitignoreに追加する。
デフォルトでは/public/uploadsに投稿された画像が保存されるようになっている。
このままでは画像が投稿されるたびに差分が生まれてしまうのでgitignoreに追記を行う。

8, viewに画像を表示する。
表示するためには画像が保存されている場所を取得する必要がある。
AvatarUploaderクラスのメソッドであるurlを使うとアップロード先のファイル情報を取得できる。
```
irb(main):002:0> user.avatar.url
=> "/uploads/user/avatar/1/120185.png"
```

これとrailsで画像を表示するためのimgタグを生成するimage_tagを使用する。
```
<%= image_tag 'ファイル名', 'オプション' %>
↑のコードから↓のHTMLコードを生成してくれる。
<img src="/assets/test.jpg" class="hoge">
```
この２つのメソッドを使う。
```ruby
<% if @user.avatar? %>  <!-- アップロード画像がある場合に実行する -->
  <p>
    <strong>Avatar:</strong>
    <%= image_tag @user.avatar.url %><!-- userインスタンスの画像ファイルのURLを取得し表示 -->
  </p>
<% end %>
```

## 複数画像をアップロードしたい。
通常との差分について述べる。
1, モデルでの設定。
・複数画像の場合、mount_uploaderではなくmount_uploadersの複数形になるので注意。
・serialize :images, JSONは、テキスト型のカラムに配列を格納するための行。
```ruby 
app/model.rb
class Post < ApplicationRecord
    mount_uploaders :images, ImageUploader
      # Rails5.0未満を使ってる場合は以下のコードも必要
    serialize :images, JSON
end
```

2, 投稿フォーム
multiple: trueとし、複数のファイルを選択できるようにする。
```
app/view/new.erb
<%= form.file_field :images, multiple: true %>
```

3, コントローラーでのparamsの受け取り方。
配列でデータを受け取るので以下のような形になる。
```ruby
#ストロングパラメータ
def post_params
  params.require(:post).permit(:body, images: [])
end
```
4, 受けっとった配列を表示する。
ここでもimageではなく複数形になっていることに注意
```ruby
- post.images.each do |image|
  .swiper-slide
    = image_tag image.url, class: 'card-img-top'
```


