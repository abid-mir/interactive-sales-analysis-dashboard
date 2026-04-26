# 📖 Data Dictionary

This document describes all tables and columns used in the Pizza Sales project.

---

## Table: `orders`
**File:** `data/orders.csv` | **Rows:** 21,350

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | Integer | Unique identifier for each customer order |
| `date` | Date (YYYY-MM-DD) | Date the order was placed |
| `time` | Time (HH:MM:SS) | Time the order was placed |

---

## Table: `order_details`
**File:** `data/order_details.csv` | **Rows:** 48,620

| Column | Type | Description |
|--------|------|-------------|
| `order_details_id` | Integer | Unique identifier for each line item |
| `order_id` | Integer | Foreign key → `orders.order_id` |
| `pizza_id` | String | Foreign key → `pizzas.pizza_id` (e.g., `hawaiian_m`) |
| `quantity` | Integer | Number of that pizza ordered in this line item |

---

## Table: `pizzas`
**File:** `data/pizzas.csv` | **Rows:** 96

| Column | Type | Description |
|--------|------|-------------|
| `pizza_id` | String | Unique identifier combining type and size (e.g., `bbq_ckn_s`) |
| `pizza_type_id` | String | Foreign key → `pizza_types.pizza_type_id` |
| `size` | String | Pizza size: S, M, L, XL, or XXL |
| `price` | Float | Price of one pizza in USD |

---

## Table: `pizza_types`
**File:** `data/pizza_types.csv` | **Rows:** 32

| Column | Type | Description |
|--------|------|-------------|
| `pizza_type_id` | String | Unique identifier for the pizza type (e.g., `bbq_ckn`) |
| `name` | String | Full display name (e.g., "The Barbecue Chicken Pizza") |
| `category` | String | One of: Classic, Chicken, Supreme, Veggie |
| `ingredients` | String | Comma-separated list of ingredients |

---

## Table: `original_table` (Denormalized / Flat)
**File:** `data/original_table.csv` | **Rows:** 48,620

This is a pre-joined flat table used directly in Power BI. It merges all 4 tables above.

| Column | Type | Description |
|--------|------|-------------|
| `pizza_id` | Integer | Row index |
| `order_id` | Integer | Order identifier |
| `pizza_name_id` | String | Pizza type + size slug (e.g., `hawaiian_m`) |
| `quantity` | Integer | Quantity ordered |
| `order_date` | Date | Date of order |
| `order_time` | Time | Time of order |
| `unit_price` | Float | Price per pizza |
| `total_price` | Float | unit_price × quantity |
| `pizza_size` | String | S / M / L / XL / XXL |
| `pizza_category` | String | Classic / Chicken / Supreme / Veggie |
| `pizza_ingredients` | String | Ingredients list |
| `pizza_name` | String | Full pizza name |

---

## Entity Relationship Diagram

```
orders (21,350)
    └── order_id (PK)
            │
            ▼
order_details (48,620)
    ├── order_details_id (PK)
    ├── order_id (FK → orders)
    ├── pizza_id (FK → pizzas)
    └── quantity
            │
            ▼
pizzas (96)
    ├── pizza_id (PK)
    ├── pizza_type_id (FK → pizza_types)
    ├── size
    └── price
            │
            ▼
pizza_types (32)
    ├── pizza_type_id (PK)
    ├── name
    ├── category
    └── ingredients
```
