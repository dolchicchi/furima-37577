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
| birthday           | date    | null: false               |


### Association

- has_many :items
- has_many :orders

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| explanation      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| status_id        | integer    | null: false                    |
| postage_id       | integer    | null: false                    |
| region_id        | integer    | null: false                    |
| days_required_id | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one :order


## orders テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_destination


## shipping_destinations テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| post_code      | string     | null: false                    |
| region_id      | integer    | null: false                    |
| city           | string     | null: false                    |
| address        | string     | null: false                    |
| building_name  | string     |                                |
| tel            | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

### Association

- belongs_to :order