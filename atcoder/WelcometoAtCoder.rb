#問題文
#高橋君はデータの加工が行いたいです。
#整数 a,b,cと、文字列 s が与えられます。 
#a+b+c の計算結果と、文字列 s を並べて表示しなさい
#
#入力
#入力は以下の形式で与えられる。
#```
#a
#b c
#s
#````
#出力
#a+b+c と s を空白区切りで 1 行に出力せよ。

### 回答
a = gets.to_i
b, c = gets.chomp.split("").map(&:to_i);
s = gets.chomp
print("#{a+b+c} #{s}\n")


# 回答するにあたって調べたこと
・\nは改行 <br/>はhtml
rubyでの改行方法がわからなかった。今回の/nのような形で他にも意味を持つものがたくさんあるみたいなので目を通しておきたい。
https://blog.mothule.com/ruby/ruby-backslash

・putsとpurintの違いについて
今まで出力する時はputsだけで行ってきたが回答例にprintで記載したので調べてみた。
違いがあることはわかったがなぜこの場合はprintが望ましいのかわからなかったので明日より深く調べる。
https://www.sejuku.net/blog/16119

・getsメソッドは文字列を変換する
最初に.to_iを忘れていたのでエラーが発生してしまった。
getsメソッドは文字列を送ってくるので数値への変換が必要。
https://qiita.com/ITmanbow/items/1ab8399946f7e5131881

・.map(&:to_i);について
もともとの形を省略するために&が使われているみたい。
ここも明日ちゃんと理解する。
https://qiita.com/snyt45/items/7beb719ab0c4a25aa585

