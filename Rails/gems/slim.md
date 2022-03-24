・slimとは
slimとはerbと同じくrubyを埋め込むことができるテンプレートエンジン。
htmlよりもコードを早く綺麗に、そして非常にシンプルに作ることができる。

・導入方法
1, gem slim-railsとhtml2slimをインストールする。
slim-railsがslimをhtmlに変換してくれる。html2slimは既存のerbをslimに変換してくれる。
2, bundle exec erb2slim app/views app/views -dをコマンドで実行。
-dオプションを付けることで既存のerbファイルも削除することができる。
3, config/application.rbにてデフォルトで生成されるファイルをslimに固定する。
```ruby
module App
  class Application < Rails::Application
    config.generators.template_engine = :slim #slimに変更
  end                                                                                                                                                                     
end
```
・基本文法
    ・<>がいらない
    ・<%= %> →  =
    ・<% %> → -
    ・コメント → /
    ・id指定 → #
    ・class指定 → .
参考資料:https://qiita.com/ngron/items/c03e68642c2ab77e7283