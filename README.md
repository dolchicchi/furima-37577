# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| kana_last_name     | string  | null: false               |
| kana_first_name    | string  | null: false               |
| year_of_birth      | integer | null: false               |
| month_of_birth     | integer | null: false               |
| date_of_birth      | integer | null: false               |


### Association

- has_many :items

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| explanation   | text       | null: false                    |
| category      | string     | null: false                    |
| status        | string     | null: false                    |
| postage       | string     | null: false                    |
| prefectures   | string     | null: false                    |
| days_required | string     | null: false                    |
| price         | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one :settlement
- has_one :shipping_destination


## settlements テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| card_number  | integer    | null: false                    |
| expiry_month | integer    | null: false                    |
| expiry_year  | integer    | null: false                    |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :item


## shipping_destinations テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefectures   | string     | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | text       |                                |
| tel           | string     | null: false                    |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :item