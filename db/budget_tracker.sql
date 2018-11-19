DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE budget;

CREATE TABLE merchants (
  id SERIAL8 primary key,
  merchant_name VARCHAR(120)
);

CREATE TABLE tags (
  id SERIAL8 primary key,
  tag_name VARCHAR(120)
);

CREATE TABLE budget (
  id SERIAL8 primary key,
  budget_name VARCHAR(120),
  budget_amount NUMERIC(8,2),
  budget_start_date DATE,
  budget_end_date DATE
);

CREATE TABLE transactions (
  id SERIAL8 primary key,
  transaction_type VARCHAR(120),
  amount NUMERIC(8,2),
  transaction_date DATE,
  merchant_id INT8 REFERENCES merchants(id) ON DELETE SET NULL,
  tag_id INT8 REFERENCES tags(id) ON DELETE CASCADE,
  budget_id INT8 REFERENCES budget(id) ON DELETE CASCADE
);
