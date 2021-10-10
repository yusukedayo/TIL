#### 今日の問題
https://atcoder.jp/contests/abs/tasks/abc086_a

#問題文
#シカのAtCoDeerくんは二つの正整数 a,b を見つけました。 a と b の積が偶数か奇数か判定してください。
#
#制約
#1 ≤ a,b ≤ 10000
#a,b は整数


### 自分の回答
a = gets.to_i
b = gets.to_i

if (a * b).even? == true
    puts "even"
else
    puts "odd"
end 


##### 回答
#a,b = gets.chomp.split(" ").map(&:to_i)
# 
#if a*b%2 == 0
#  puts "Odd"
#elsif a*b%2 == 1
#puts "Even"
#end
#
##### 振り返り
・入力例について
入力例が  3 4  のように与えられていたので単に
a = gets.to_i
b = gets.to_i
とするのではなく
a,b = gets.chomp.split(" ").map(&:to_i)
.chompメソッドで改行を防ぐのに加えて.splitでスペースで２つの数字を
分けるようにする。その上でまとめてデータを数値化することが必要だった。

・.even?メソッドについて
自分の書いた.evenを使った方法でもちゃんと期待された出力はできたので問題はないと思う。
ただ回答例も１つの方法としてちゃんと覚えるようにしていきたい。
%はあまりの数を教えてくれる。２で割って最終的に0か1かで奇数・偶数を判断している。
https://docs.ruby-lang.org/ja/latest/method/Integer/i/even=3f.html