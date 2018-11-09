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
  amount INT2,
  transaction_date DATE,
  tag_id INT8 REFERENCES tags(id),
  merchant_id INT8 REFERENCES merchants(id)
);

CREATE TABLE wallet (
  id SERIAL8 primary key,
  cash_balance INT2,
  budget_amount INT2,
  budget_start_date DATE,
  budget_end_date DATE
);
