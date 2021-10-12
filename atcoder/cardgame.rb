https://atcoder.jp/contests/abs/tasks/abc088_b

問題文
N 枚のカードがあります. i 枚目のカードには, a 
iという数が書かれています.
Alice と Bob は, これらのカードを使ってゲームを行います. ゲームでは, Alice と Bob が交互に 1 枚ずつカードを取っていきます. Alice が先にカードを取ります.
2 人がすべてのカードを取ったときゲームは終了し, 取ったカードの数の合計がその人の得点になります. 2 人とも自分の得点を最大化するように最適な戦略を取った時, Alice は Bob より何点多く取るか求めてください.


N = gets.to_i
a = 0
b - 0
ary = gets.chomp.split(" ").map(&:to_i)
ary.sort.reverse
N.times do |z|
    if z % 2 == 0
        a += ary[z]
    else
        b += ary[i]
    end
end

puts a - b


・「！」について。
！を付けることによって例外を発生させることができる。
https://qiita.com/ozin/items/5968971c9d2b3ab0a84d



