# 夏の赤ペン先生

写真から夏っぽさを採点するスマホアプリ

developed at ハックツハッカソン 〜スピノカップ〜 2021/9/20 - 22

## 概要

夏休み最終日。その夏を振り返りながら自分が過ごした夏の日々を採点しよう。

## 開発技術

- Flutter
- FastAPI
- Docker
- Azure Container Instance
- Azure Container Registory
- Google vision api
- Word2Vec
- Firebase Authentication
- Firebase Storage
- PostgreSQL

## リンク

- [フロントエンド(ここ)](https://github.com/citrus-candy/summer-scoring-app)
- [バックエンド](https://github.com/PigeonsHouse/spino-server)


## インフラ構成図

<img src="https://user-images.githubusercontent.com/43461456/147136173-bd3471c2-9e2f-4e4f-ad3d-632c9f64fd96.png" width="800px">

## 役割分担

### フロントエンド
- [@citrus-candy](https://github.com/citrus-candy)
  - Flutterはいいぞ！

デザインや UI/UX にこだわりました。

テーマの変更機能やチュートリアル画面を実装したり、Lottie というサービスでアニメーションを実装したりするなどユーザーに飽きさせないような工夫をしました。

### バックエンド
- [@Simo-C3](https://github.com/Simo-C3)
  - 初めてのバックエンド楽しかった！採点のとこきつかったです。。。
- [@PigeonsHouse](https://github.com/PigeonsHouse)
  - ハッカソン中にエンドポイントのテストを書き終えられたので満足です。☺

ユーザー登録や画像採点、採点情報の取得、画像ごとやユーザーごとのランキングの取得などのエンドポイントを実装しました。

また、それらのエンドポイントのテストコードも書き、エラーの少ないバックエンドになっております。

## 採点について

点数は100点満点での採点です。

### 採点方法

1. ユーザーの画像を Google vision api でラベル化
2. 1.のラベルを Word2Vec のモデルを使い、解析（詳細略：GitHub のコード見て頂けると助かります）
3. 点数を100点満点に換算

Google vision api でラベル化したものでNGワードに指定したものが含まれる場合問答無用で0点としています。

### Word2Vec のモデル作成について

Word2Vec は本来文章を形態素解析して学習させるものとなります。しかし、今回は画像から画像内の要素を単語化（ラベル化）し、その単語群で学習させました。目的は夏っぽい画像から取り出したラベル群の関係性を見つけるためとなっています。

Bing Image API でキーワード検索の結果（URL）を取得し、それを Cloud vision API に投げることでラベル化をしています。その、ラベルデータをテキストデータとして保存し、それを使って Word2Vec の学習を行いました。

### 試行錯誤したこと

- 複数のモデルを作り組み合わせて使う
- モデルを使った別の解析方法
- 教えてもらったサービスの使用検討

### 悪あがきしたこと

- ラベルに`Snow`が入っている場合は0点

### 結果

精度はあまり高くありませんでしたが一番良い結果が出た現在の方法を取っております。

## 注意事項

このアプリでの採点はあくまでネタとして見てください。投稿する画像や画像の種類よって夏の画像であっても点数が低く出ます。

また、逆もしかりです。冬の画像でも高得点が出る可能性があります。


## スクリーンショット

右の画像は開発段階のものです！！なぜ、ポプテピの画像が高得点をたたき出したのかはわかっていません。。。。

<img src="https://user-images.githubusercontent.com/43461456/147136719-09750be4-8e28-40f6-bc80-e1506671fdbe.png" width="450px"><img src="https://user-images.githubusercontent.com/43461456/147136747-5952997e-2364-4d3a-94a1-bddf93d1a601.png" width="450px">
