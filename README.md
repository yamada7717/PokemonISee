## 自己紹介

初めまして、Hiroと申します！現在未経験からWebエンジニアを目指し転職活動中です。

## プログラミングを始めた理由とエンジニアを目指す理由
働きながら空き時間にできることを探している中でWeb制作を学んだことが、私の転職のきっかけとなりました。新しい職場ではLaravelを学ぶ機会があり、それを通じてプログラミングの楽しさに目覚め、より本格的にプログラミングを極めたいと感じました。そのためより体系的に学ぶためにポテパンキャンプを受講することにしました。実際に手を動かしてみることで、自分のアイデアを形にし使用者からフィードバックをもらえる点に大きな魅力を感じました。自分の技術で他者に貢献し、さらに多くの人々に役立つサービスを提供したいと強く思い、エンジニアを目指すことを決意しました。

 # PokemonISee
![トップページ](https://github.com/user-attachments/assets/d78d3243-8f66-4bc5-b272-7e1a13c0dc66)

## サービズ名
PokemonISee（ポケモンアイシー）
「PokemonISee」の由来は、ポケモンの構築記事を読んでいる際にユーザーが「なるほど！」と納得し、新たな視点や理解を得る瞬間に着目しています。このサービス名には、ユーザーがポケモンバトルやチーム構築における深い戦略を理解し、見えていなかったものが「見える」ようになるという願いが込められています。

## アプリURL
PokemonISee
(https://pokemonisee-de9c305e7304.herokuapp.com/)

## アプリを作成した背景
まず、ポケモンに関する情報が一箇所に集まるサイトを作りたいという思いがありました。その中で、ポケモンをプレイしている友人に現行の構築記事サイトで感じている不便さを尋ねたところ、「プレイヤー名と使用しているポケモン名や持ち物を同時に検索できない」という課題が浮かび上がりました。このフィードバックをヒントに、より便利な検索機能を備えたサイトを作成することにしました。

## 機能一覧

| 機能                          | 説明                                                                                     |
|-------------------------------|------------------------------------------------------------------------------------------|
| **会員登録・ログイン**     | Sorceryを使用してユーザーの会員登録とゲストログイン機能を実装。                                 |
| **メールを使用したパスワードリセット** | Sorceryを使用してユーザーがメールを使ってパスワードをリセットできる機能。                       |
| **構築記事投稿**           | ユーザーがポケモンの構築記事を投稿し、共有できる機能。                                   |
| **ポケモンパーティ登録**   | 構築記事に紐づいたポケモンのパーティを登録し、保存できる機能。                                             |
| **検索**                  | ユーザー名、ポケモン名、順位、持ち物、シーズンなどの条件で構築記事を検索できる機能。       |
| **構築記事公開・非表示**        | 特定の記事を公開・非表示にする機能。                                                          |
| **お気に入り機能**             | 気に入った構築記事をお気に入りに登録する機能。                                           |
| **フォロー機能**               | 他のユーザーをフォローして、最新の構築記事を追跡できる機能。                              |

## 機能紹介
### トップページ
サービスの目的とどのシリーズに関するサイトのなのかを明白にしています。
![トップページ](https://github.com/user-attachments/assets/d78d3243-8f66-4bc5-b272-7e1a13c0dc66)

### コンテンツページ
コンテンツページでは、ユーザーが公開している構築記事の順位やシーズンごとのポケモンパーティを確認できます。さらに、PokeAPIを活用してポケモンの画像を表示することで、視覚的にも楽しめるページとなっています。
#### コンテンツページの工夫点
- **ページネーション**: 投稿は新しい順に10件ずつ表示されるようにページネーションを導入し、ユーザーが最新の情報に迅速にアクセスできるようにしました。また、ページの読み込み負担を軽減し、快適な閲覧体験を提供するための工夫も施しています。
- **バトル形式別のページ構成**: ポケモンバトルには「シングルバトル」と「ダブルバトル」があり、それぞれのバトル形式に応じたコンテンツページを用意しました。これにより、ユーザーは自分が参考にしたいバトル形式に絞って記事を閲覧でき、必要な情報に効率よくアクセスできるようにしています。
- **ユーザー毎のカスタマイズ**: 各バトル形式に対応する記事を個別にコンテンツとしてまとめることで、ユーザーが自分に合った戦略や情報を簡単に見つけられるよう工夫しました。


https://github.com/user-attachments/assets/bb613952-7ba5-4604-a322-1e0db1e3fb45

### ポケモンパーティー登録
#### ポケモンパーティ登録時の工夫点
- **ポケモン名の検索**: 登録したいポケモン名を検索することで、数多くのポケモンの中から目的のポケモンを素早く見つけ出し、手間を省いて簡単に登録できるようにしました。
- **もちものの選択**: もちものはセレクトボックスから選択できるようにしており、選択したもちものを持たせたままポケモンを登録できる工夫をしています。これによりユーザーが効率的にパーティを構築できるようにしました。


https://github.com/user-attachments/assets/3ca63d18-b09b-43e0-bcc9-9abe888f2e2a


 ### 使用技術

### バックエンド

| 使用技術 | 詳細 |
|--------------|-----------|
| **Ruby 3.2.0** | プログラミング言語。 |
| **Rails 7.0.8** | Webアプリケーションフレームワーク。 |
| **PostgreSQL** | データベース。 |
| **Sorcery** | ユーザー認証機能の実装。 |
| **Faraday** | HTTPクライアントライブラリ、API連携に使用。 |
| **AWS SDK S3 (`aws-sdk-s3`)** | AWS S3への接続と操作を可能にする。 |
| **Pagy** | シンプルで高速なページネーション機能。 |
| **Dotenv-Rails (`dotenv-rails`)** | 環境変数の管理。 |

### フロントエンド

| 使用技術 | 詳細 |
|--------------|-----------|
| **Importmap-Rails (`importmap-rails`)** | JavaScriptのモジュール管理に使用。 |
| **Tailwind CSS (`tailwindcss-rails`)** | UIデザインを容易にするCSSフレームワーク。 |
| **jQuery** | DOM操作やイベントハンドリングを簡便に行うためのJavaScriptライブラリ。 |

### インフラ

| 使用技術 | 詳細 |
|--------------|-----------|
| **Heroku** | アプリケーションのデプロイと運用に使用。簡単なデプロイプロセスとスケーリングオプションを提供。 |
| **AWS S3** | データストレージに使用。画像やファイルの保存と取得に利用。 |

### API

| 使用技術 | 詳細 |
|--------------|-----------|
| **PokeAPI** | ポケモンデータの取得に使用。ポケモンの画像やステータス情報をアプリ内で表示。 |


### 開発・テスト環境

| 使用技術 | 詳細 |
|--------------|-----------|
| **Rspec-Rails** | テストフレームワーク。 |
| **Factory Bot Rails** | テストデータの作成を簡素化。 |
| **Rubocop** | コード品質を保つためのツール。 |
| **Letter Opener Web** | 開発中のメール確認に使用。 |
| **Capybara** | システムテストのためのツール。 |
| **Selenium WebDriver** | ブラウザ自動操作ツール。 |

## ER図
![ER図](https://github.com/user-attachments/assets/0386a669-bb33-4d23-b074-4a3068ffa47a)

## 今後実装したい機能
### PokemonISee
**リアルタイムチャット機能**
  - ユーザーがリアルタイムで構築記事やポケモンバトルについて意見交換できるチャット機能。
  - ActionCableを使用してリアルタイム通信を実現。バックエンドでRails、フロントエンドでJavaScriptやStimulusを組み合わせ実装できると考えています。

 **お気に入りが多い注目記事機能**
   - ユーザーがお気に入り登録した数が多い構築記事をランキング形式で表示する機能。
   - データベースでお気に入り数をカウントし、特定の閾値を超えた記事を「注目記事」として表示し構築記事を投稿したいと思えるよう促したい。

 **登録されたポケモンの使用率がわかる機能**
   - 登録されたポケモンの使用データを集計し、どのポケモンがよく使われているかを可視化する機能です。注目記事がプレイヤーに影響を与え、その結果使用したいと思えるポケモンがどれだけ頻繁に使われているかを見ることができる点が興味深いと考えています。
   - データベースでポケモンの登録数を集計し、グラフやランキングで視覚的に表示するために、`Chart.js`や`Highcharts`を活用したい。

## 自己PR

私は、ポケモン構築記事を読む友人の声をきっかけに、ユーザーフレンドリーな構築記事サイトを作成しました。友人へのヒアリングを通じて、既存サイトに以下の問題点があることがわかりました。

### 既存サイトの問題点
- **検索機能が不十分**: プレイヤー名やポケモン名、ポケモンパーティが使用されたシーズン、持ち物を同時に検索できない。
- **プライバシー設定が不便**: 記事の公開・非公開が切り替えられない。

### 実装した機能とそのメリット
- **ポケモン名や持ち物の同時検索機能**
  構築記事から素早く必要な情報を見つけることができ、ユーザーの利便性を向上させました。

- **構築記事の公開・非公開機能**
  ユーザーが記事の公開範囲を自由に設定でき、プライバシー管理を容易にしました。

- **ポケモンパーティ画像表示機能**
  PokeAPIを利用し、ポケモンパーティを視覚的に表示。直感的に記事を把握できるようになり、ユーザー体験を向上させました。

### 学びと今後の目標
このプロジェクトを通じて、ユーザー視点での要件定義やフィードバックを基にした機能改善の重要性を学びました。今後も、ユーザーにとって価値のあるサービスを提供するエンジニアを目指してスキルを磨いていきたいと考えています。
ここまで読んでいただき本当にありがとうございました！
