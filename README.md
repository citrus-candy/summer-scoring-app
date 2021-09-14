# 夏の赤ペン先生

## 開発技術

### フロントエンド

- Flutter

### バックエンド

- FastAPI

### 認証

- Firebase Authentication

### 採点

- 画像
    - Microsoft Azure - Computer Vision
- 単語
    - word2vec

## API仕様

| アクセスURI | メソッド | 説明 | クエリ | 説明 |
| --- | --- | --- | --- | --- |
| /api/v1/signup | POST |　ユーザー登録 |
| /api/v1/scoring | POST |　画像の採点 |
|  /api/v1/ranking/posts | GET |　投稿ごとの点数ランキング取得 | limit | 取得情報個数 |
| /api/v1/posts/me | GET |　自分の投稿取得 |
| /api/v1/users/me | GET |　自分のユーザー情報取得 |

### signup - ユーザー登録

#### HEADERS
- Authorization: Bearer <token: string>

#### RESPONSE

| key | 型 | 説明 |
| --- | --- | --- |
| id | string | firebaseのUID |
| name | string |　ユーザー名 |
| created_at | timestamp |　作成日時 |
| updated_at | timestamp |　更新日時 |

### scoring - 画像の採点

#### HEADERS
- Authorization: Bearer <token: string>

#### REQUEST

| key | 型 | 説明 |
| --- | --- | --- |
| img_url | string | 画像URL |

#### RESPONSE

| key | 型 | 説明 |
| --- | --- | --- |
| id | string | index |
| user | object | ユーザー情報 |
| - id | string | firebaseのUID |
| - name | string | ユーザー名 |
| - created_at | timestamp | 作成日時 |
| - updated_at | timestamp| 更新日時 |
| point | float | 採点した点数 |
| rank_post | int | 投稿ごとのランク |
| rank_user | int | ユーザーごとのランク |
| created_at | timestamp |　作成日時 |
| updated_at | timestamp |　更新日時 |

### ranking/posts - 投稿ごとの点数ランキング取得

#### HEADERS
- Authorization: Bearer <token: string>

#### QUERY

| key | 型 | 説明 |
| --- | --- | --- |
| limit | int | 取得情報個数 |

#### RESPONSE

| key | 型 | 説明 |
| --- | --- | --- |
|  | array | ランキングの配列 |
| - id | string | index |
| - user | object | ユーザー情報 |
| - -  id | string | firebaseのUID |
| - - name | string | ユーザー名 |
| - - created_at | timestamp | 作成日時 |
| - - updated_at | timestamp| 更新日時 |
| - point | float | 採点した点数 |
| - rank_post | int | 投稿ごとのランク |
| - rank_user | int | ユーザーごとのランク |
| - created_at | timestamp |　作成日時 |
| - updated_at | timestamp |　更新日時 |

### posts/me - 自分の投稿取得

#### HEADERS
- Authorization: Bearer <token: string>

#### RESPONSE

| key | 型 | 説明 |
| --- | --- | --- |
| id | string | index |
| user | object | ユーザー情報 |
| - id | string | firebaseのUID |
| - name | string | ユーザー名 |
| - created_at | timestamp | 作成日時 |
| - updated_at | timestamp| 更新日時 |
| point | float | 採点した点数 |
| rank_post | int | 投稿ごとのランク |
| rank_user | int | ユーザーごとのランク |
| created_at | timestamp |　作成日時 |
| updated_at | timestamp |　更新日時 |

### users/me - 自分のユーザー情報取得

#### HEADERS
- Authorization: Bearer <token: string>

#### RESPONSE

| key | 型 | 説明 |
| --- | --- | --- |
| id | string | firebaseのUID |
| name | string |　ユーザー名 |
| created_at | timestamp |　作成日時 |
| updated_at | timestamp |　更新日時 |
