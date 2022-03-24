* docker経由でMySQLを起動しようとした時に以下のエラーが発生した。

```
C:\Users\yusuketsunemi\Desktop\effort>docker-compose up
[+] Running 3/3
 - Network effort_default  Cre...                          0.9s
 - Container effort-db-1   Crea...                         0.3s
 - Container effort-web-1  Cre...                          0.3s
Attaching to effort-db-1, effort-web-1
Error response from daemon: Ports are not available: listen tcp 0.0.0.0:3306: bind: Only one usage of each socket address (protocol/network address/port) is normally permitted.
```

* エラー文を翻訳してみると **通常、各ソケットアドレス（プロトコル/ネットワークアドレス/ポート）は1回のみ使用可能です**
とのこと。これだけだといまいち意味が掴めないが恐らく１つのPCから1つ以上MySQLを起動しようとしたのが原因。

* 実際に自分のPCを確認するとMySQLが起動したままになっていた。これをstopするとエラーは解決した。