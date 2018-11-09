DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE wallet;

CREATE TABLE merchants (
  id SERIAL8 primary key,
  merchant_name VARCHAR(120)
);

CREATE TABLE tags (
  id SERIAL8 primary key,
  tag_name VARCHAR(120)
);

CREATE TABLE transactions (
  id SERIAL8 primary key,
  transaction_type VARCHAR(120),
  amount NUMERIC,
  transaction_date DATE,
  merchant_id INT8 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT8 REFERENCES tags(id) ON DELETE CASCADE
);

CREATE TABLE wallet (
  id SERIAL8 primary key,
  cash_balance NUMERIC,
  budget_amount NUMERIC,
  budget_start_date DATE,
  budget_end_date DATE
);
