
### 文字列の表示
console.log("name");
これで **name** という文字列を表示することができる。

### 変数の使い方
* 変数を扱う場合はletで変数の宣言を行い、変数名に=で値を代入する。変数を呼び出すことで値を出力することができる。（変数は""で囲まないので注意が必要)
let name = "akira";
console.log(name);

* 変数の変更を行う場合
変更を行う場合は「変数名 = 新しい値」をすれば良い。この場合はlet1を記述する必要はない。

### 定数とは
定数は変数とよく似ているが一度定義したものを変更することはできない。定数を扱う場合は以下のようにconstで宣言をし、以下は変数と同じである。
const name = "John"

### テンプレートリテラルについて
以下のようにコードを書くことで定数を文字列の中に含めることができる。この時、全体をシングルクォーテーションで囲むことに注意。
const name = "にんじゃわんこ";
const age = 14;
// 「ぼくの名前は〇〇です」とコンソールに出力してください
console.log(`ぼくの名前は${name}です`);


### 条件分岐について
* 条件式の書き方について
if(条件式){
    条件式が成り立てば実行される処理
}

* 比較演算子について
「a === b」はaとbが等しければtrue、等しくなければfalseになる。
「a !== b」はその逆です。

* elseを使う条件分岐
const age = 17;

// 条件式が成り立たない場合に「私は20歳未満です」と出力してください
if (age >= 20) {
  console.log("私は20歳以上です");
} else {
  console.log("私は20歳未満です");
}

* else ifを使った条件分岐
const age = 17;

// ageの値が10以上20未満のとき、「私は20歳未満ですが、10歳以上です」と出力してください
if (age >= 20) {
  console.log("私は20歳以上です");
} else if (age >= 10) {
  console.log("私は20歳未満ですが、10歳以上です");
} else {
  console.log("私は10歳未満です");
}

* switch文について
ある値によって処理を分岐する場合にswitch文を用いることができます。

```js
const rank = 2;

switch (rank) {
  case 1:
    console.log("金メダルです！");
    break;
    // breakによってswitch文を終了させる命令が出されている。
  case 2:
    console.log("銀メダルです！");
    break;
  case 3:
    console.log("銅メダルです！");
    break;
  default:
    console.log("メダルはありません");
    break;
  // デフォルトによってどの条件にも当てはまらない場合の処理を指定できる。
}
```

### 繰り返し文

* while文
```js
let number = 1;
while(number <= 100>){
  // ()内に条件式を書く
  console.log(number);
  number += 1;
  {}内の処理が条件を達成するまで繰り返される。
}
```

* for文
for文では「変数の定義」「条件式」「変数の更新」の3つを括弧の中に書くことができる。
```js
for(let number = 1; number <= 100; number += 1){
  // 変数の定義       条件式        変数の更新
  console.log(number);
}
```


### 配列について
複数の要素を1つにまとめたい場合は以下のようにすることで配列にすることができる。
配列の要素は0から数える。以下の例だとdog[0],cat[1],sheep[2]
```js
const animals = ["dog", "cat", "sheep"];
// 定数animalsを出力して下さい
console.log(animals);
→"dog", "cat", "sheep"
```
配列は以下のように要素に値を代入することで値を変更することができる。
```js
const animals = ["dog", "cat", "sheep"];

// 配列animalsの3つ目の要素を「rabbit」に更新してください
animals[2] = "rabbit";

// 配列animalsの3つ目の要素をコンソールに表示して下さい
console.log(animals[2]);
→'rabbit'
```
配列と繰り返し文を組み合わせることで配列の要素を全て出力することができる。
また、lengthメソッドを使うと配列の要素数を取得できるので簡単にコードが書ける。
```js
const animals = ["dog", "cat", "sheep"];

// for文を用いて、配列の値を順にコンソールに出力してください
for (let i = 0; i < animals.length; i++) {
  console.log(animals[i]);
}
```

### 関数について
関数とはコードを1つの塊としてまとめ、何度も再利用できるようにする仕組みのこと。


#### 関数宣言と関数式
* 関数宣言…同じ関数名を使った場合は最後の関数に上書きされる。
```js
function myFunc() {
      console.log('これは関数宣言です');
    }
    myFunc1(); // 関数の実行
```

* 関数式…関数自体を変数に格納する。同じ変数名を使った場合はエラーが発生。
```js
const myFunc = function() {
  
    // 処理を記述する
  
}

// 以下のように省略することができる。アロー関数と言われる。

const myFunc = () => {
        console.log('これは関数式です');
    }
    myFunc2(); // 関数の実行

// 引数を指定することも可能
const myFunc = (keyword) => {
  console.log('指定した文字は、「' + keyword + '」ね？');
}

myFunc('プログラミング');
```

### promptで文字入力を行う。
promptを使用することでユーザーから文字列 or 値を受け取ることができる。
```js
<script>
  var name = prompt("名前を入力してください","キラメキタロウ");
  // この場合だとキラメキタロウが初期値として設定されている。
  document.write(name);
</script>
```

