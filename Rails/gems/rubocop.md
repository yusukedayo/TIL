## rubocopとは
Rubyの静的コード解析を実行するgem。インデントや長すぎるコードを指摘してくれる。

### 導入方法
1, gem rubocopをインストールする。
```
Gemfile
group :development do
    gem 'rubocop', require: false
end
```
2, .rubocop.ymlファイルを作成する。
RuboCopの設定ファイルです。対象となるファイルの種類だったり、チェックする構文のデフォルトを変えたりと,自分たちのコーディングスタイルに沿った現実的なルールをこのファイルで適用します。
3, 基本コマンドを使って操作する。
```
$ rubocop
#解析して結果をターミナルに吐き出す。
$ rubocop --help
# ヘルプを参照できます。
$ rubocop --lint( または rubocop --rails )
# チェック規則は以下の4つに分類されますが --lint がLintのみチェック、 --rails がRailsのみチェック
# -------------------------------------------------------------------------
# 1 Style   (スタイルについて)
# 2 Lint    (誤りである可能性が高い部分やbad practiceを指摘する)
# 3 Metrics (クラスの行数や1行の文字数などに関して)
# 4 Rails   (Rails特有のcop)
$ rubocop --auto-gen-config 
# .rubocop_todo.ymlに警告を一旦退避する。
# .rubocop.ymlに "inherit_from: .rubocop_todo.yml" と書くのを忘れないでください。
$ rubocop --auto-correct 
# 直せる箇所を自動で修正してくれます。(最初は使わないで警告されたコードを眺めてみることをお勧めします。)
```
参考記事:https://qiita.com/tomohiii/items/1a17018b5a48b8284a8b