> [!WARNING]
> [[https://github.com/mvmmvm/mymys](https://github.com/mvmmvm/mymys)]へ移動しました

### 画面遷移図
Figma：https://www.figma.com/file/eWBmUHClXYpwZpgkLUS1tm/MyStoryScreenTransitionDiagram?type=design&node-id=0%3A1&mode=design&t=GIYAehHjQlck7rYt-1

### ER図
https://drive.google.com/file/d/1XLFnNdyAmHqlE9-l6-ipyPVm7pcgqEVe/view?usp=sharing

### 環境構築方法

1. 初回のみ管理者に.envファイルを共有してもらい、プロジェクト直下に入れて下さい。
2. 下記のコマンドを打ちます。
```
docker compose build
```
```
docker compose up
```
- 初回のみ
```
docker compose exec web bash
```
```
rails db:create
```
- 初回・マイグレーション（DB変更）時
- マイグレーションの際は、一旦schema.rbを削除すること
```
rails db:migrate
```


### デプロイ方法
## バックエンド
1. 事前準備として下記いずれかの方法でflyctlをインストールしておきます。
- macOS
```
brew install flyctl
```
```
curl -L https://fly.io/install.sh | sh
```
- Linux
```
curl -L https://fly.io/install.sh | sh
```
- Windows
```
pwsh -Command "iwr https://fly.io/install.ps1 -useb | iex"
```


2. トークンを管理者から教えてもらい下記のコマンドを打ちます。
```
fly auth login -t [トークン]
```
3. デプロイします。
 ```
fly deploy
 ```
## フロントエンド

■サービス概要

ユーザーが名前（三人分）を入力し、生成ボタンを押すと手軽なマーダーミステリーが作成されるサービスです。
生成後、各ユーザーは自分の名前が表示されているページで役割と情報を元にディスカッションし、犯人を当てるか、犯人はあてられないようにします。
選択結果に応じて犯人側か犯人以外側の勝敗が決まります。作ったゲームは一覧ページで他のユーザーがプレイすることも可能になります。

■このサービスへの思い・作りたい理由

コロナで孤独感を感じたり、連絡したくても連絡する理由がなかったりして、若い人たちには孤独が蔓延りました。
現在私も双極性障害を発症していますが、遊ぶのは億劫です。
離れてしまって遊ぶことも難しい友人たちや、そのように孤独や障害、病気を抱えた人でも、簡単に交流しなおせる機会を作りたいと思いました。
実際、友人の持つボードゲームで遊んだ経験があり、大変盛り上がり仲も深まりましたが、ボードゲームは嵩張るし、
人狼などのゲームは、セオリーなど、経験者の方が有利だったりするため、手が出しにくいと思いました。

■ユーザー層について

3人以上の仲間内でよく遊ぶような、10代~30代をメインターゲットとしています。
また、インドアで出かけるのが億劫な方、何の理由もなしに友達に連絡しにくかったり話題を作るのが難しい方も対象にしたいと思っています。
私は友達も多いですが、より多く友達を持ち、友達の友達などとも交流する機会があります。
こういった楽しみがあれば現在孤独を抱えやすい社会で、元気を取り戻したり、活動的になれたりする方が少しでも増えるのではないかと思いそのような考えに至りました。

■サービスの利用イメージ

名前を入れて、ジェネレータの作成ボタンを押すだけで、ミステリーゲームが完成します。
（何度か技術選定において試行しましたが、AIを使うことで時間がかかるのと、生成に失敗することがあるのが現時点での問題）
ローカル環境で試してみたところ、最大5分時間がかかるため、非同期とし、作成完了後ページが切り替わるようにします。
これについては一旦画面を閉じて、LINE通知を待ってアクセスできるようにしようと思っています。
それぞれのユーザは配布された別々の情報をもとに、自分の達成条件、勝利条件を目指します。
また、既に作られたゲームを編集し直して、自分オリジナルのゲームを人に遊んでもらうこともできるようにしたいと思っています。

■ユーザーの獲得について

友達づてで遊んでもらっていき、レーティングや、自動作成したミステリーゲームの編集などもできるようにし、
自分が手直ししたオリジナルストーリーをシェアするなどして広がっていけばいいと思っています。

■サービスの差別化ポイント・推しポイント

複数人で遊ぶ時、行く場所や遊ぶ内容がマンネリ化する状態を、毎回新鮮なゲームを通して解決できます。
自動生成のため何度でも遊べて、webサービスのため場所を取らず、場所を選ばず、リアルタイムでも、通話中でも楽しめる（チャット機能も作りたい）

■機能候補

* ストーリー・キャラクター生成登録機能（非同期）feat.OpenAI ChatGPT API ※
* ストーリー一覧機能 ※
* プレイヤー・ルーム登録機能 *
* プレイヤー一覧機能 *
* プレイヤー詳細機能 ※
* 回答機能 ※
* 結果表示機能 ※
* ストーリー検索機能
* ストーリー編集機能
* ストーリーレーティング機能
* チャット機能
* LINE通知機能
* 4人~以上でのプレイ機能（最初は3人決めうちにしようと思っています）
* 作成機能使用回数上限機能（AIが生成の失敗をすることもあるため何をもって上限とするか）
* 投げ銭or有料機能（使用回数によっては運用コストが大変なことになるため）

■機能の実装方針予定

ある程度のラインまで機能を作りましたが、ChatGPT AIかGoogle Bardの技術選定で迷いがあります。
一番難しいのはAIへの作成指示かもしれません。
またLINE APIを使用する予定ですが、MVPの範囲に入れるかは定まっていません。
「機能候補」において※の付いているものはMVPの範囲に確実に入れようと思っています。
あとはUIについて詳しくないので、画面遷移自体は確定的ですが、フロントエンドデザインについては
ほぼ定まっていません。
