## shallowルーティング
### shallowルーティングとは
shallowは、ネストしたルーティングにおいて、下層にあるテーブルのIDが一意なら、その上にあるテーブルのIDは不要にすること。
comment機能などでUserテーブル,Postsテーブル,Commentsテーブルの３つがあった場合PostとCommentsに対して行う。

<br>

### 書き方
- - -
shallow: trueを追加してあげればok
```ruby:config/routes.rb
resources :posts, shallow: true do
  resources :comments
end
```
<br>

### メリット
- - -
    ・URLとヘルパーをスッキリさせることができる。
    shallowあり edit_comment        /posts/:post_id/comments/:id/edit
    shallowなし edit_post_comment   /comments/:id/edit
<br>

### デメリット
- - -
    ・RESTfulじゃなくなってしまう。
    newとdestroyのリダイレクト先の設定が難しくなるらしい。
    ・混乱を招くかも
    シンプルな故にネストしているのかURLからわかりづらくなる
<br>

参考記事:
https://qiita.com/tanutanu/items/a245f7691c77b56d4cd3
https://qiita.com/kuboon/items/96bbd227f9497ed81f38