## 📦 データベース設計（ER図ベース）

### 🔑 Users（ユーザー）
| Column             | Type   | Options                        |
|--------------------|--------|---------------------------------|
| nickname           | string | null: false                    |
| email              | string | null: false, unique: true      |
| encrypted_password | string | null: false                    |
| last_name          | string | null: false                    |
| first_name         | string | null: false                    |
| last_name_kana     | string | null: false                    |
| first_name_kana    | string | null: false                    |
| birthday           | date   | null: false                    |

**Association**
- has_many :items
- has_many :orders

---

### 🛒 Items（商品）
| Column        | Type       | Options                        |
|---------------|------------|---------------------------------|
| name          | string     | null: false                    |
| description   | text       | null: false                    |
| category_id   | integer    | null: false                    |
| condition_id  | integer    | null: false                    |
| price         | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

**Association**
- belongs_to :user
- has_one :order

---

### 💳 Orders（購入情報）
| Column   | Type       | Options                        |
|----------|------------|---------------------------------|
| user     | references | null: false, foreign_key: true |
| item     | references | null: false, foreign_key: true |

**Association**
- belongs_to :user
- belongs_to :item
- has_one :address

---

### 🏠 Addresses（配送先）
| Column         | Type       | Options                        |
|----------------|------------|---------------------------------|
| postal_code     | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| city            | string     | null: false                    |
| house_number    | string     | null: false                    |
| building_name   | string     |                                |
| phone_number    | string     | null: false                    |
| order           | references | null: false, foreign_key: true |

**Association**
- belongs_to :order
