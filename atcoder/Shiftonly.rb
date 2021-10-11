#### 今日の問題
https://atcoder.jp/contests/abs/tasks/abc081_a

問題文
すぬけ君は 1,2,3 の番号がついた 3 つのマスからなるマス目を持っています。 各マスには 0 か 1 が書かれており、マス i には s 
iが書かれています。
すぬけ君は 1 が書かれたマスにビー玉を置きます。 ビー玉が置かれるマスがいくつあるか求めてください。


s = gets.chars.map{ |c| c.to_i}
puts s.count(1)




・.chars
文字列の各文字を文字列の配列で返す。
"hello世界".chars # => ["h", "e", "l", "l", "o", "世", "界"]

https://docs.ruby-lang.org/ja/latest/method/String/i/chars.html

・.count
レシーバの要素数を返します。
引数を指定しない場合は、レシーバの要素数を返します。このとき、要素数を一つずつカウントします。
引数を一つ指定した場合は、レシーバの要素のうち引数に一致するものの個数をカウントして返します(一致は == で判定します)。
enum = [1, 2, 4, 2].each
enum.count                  # => 4
enum.count(2)               # => 2
https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/count.html


