require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative('tag')
require_relative('merchant')
require_relative('wallet')

class Transaction

  attr_reader :id
  attr_accessor :transaction_type, :amount, :transaction_date, :tag_id, :merchant_id, :wallet_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @transaction_type = options['transaction_type']
    @amount = options['amount'].to_f
    @transaction_date = options['transaction_date']
    @merchant_id = options['merchant_id']
    @tag_id = options['tag_id']
    @wallet_id = options['wallet_id']
  end


# class functions ------------
  def self.delete_all()
    sql = "SELECT * FROM transactions
    ORDER BY transaction_date DESC;"
    SqlRunner.run( sql )
  end


  def self.all()
    sql = "SELECT * FROM transactions
    ORDER BY transaction_date DESC"
    transaction_data = SqlRunner.run(sql)
    transactions = map_items(transaction_data)
    return transactions
  end

  def self.sort_by_date
    sql = "SELECT * FROM transactions ORDER BY transaction_date DESC;"
    transaction_data = SqlRunner.run(sql)
    transactions = map_items(transaction_data)
    return transactions
  end

  def self.sort_by_tag
    sql = "SELECT *
    FROM transactions
    INNER JOIN tags
    ON tags.id = transactions.tag_id
    ORDER BY tag_name ASC;"
    transaction_data = SqlRunner.run(sql)
    transactions = map_items(transaction_data)
    return transactions
  end

  def self.sort_by_merchant
    sql = "SELECT *
    FROM transactions
    INNER JOIN merchants
    ON transactions.merchant_id = merchants.id
    ORDER BY merchant_name ASC;"
    transaction_data = SqlRunner.run(sql)
    transactions = map_items(transaction_data)
    return transactions
  end

  def self.sort_by_type
    sql = "SELECT * FROM transactions ORDER BY transaction_type ASC;"
    transaction_data = SqlRunner.run(sql)
    transactions = map_items(transaction_data)
    return transactions
  end

  def self.sort_by(input)
    result = case input
    when "type"
      sort_by_type
    when "tag"
      sort_by_tag
    when "merchant"
      sort_by_merchant
    else
      sort_by_date
    end
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    transaction_data = SqlRunner.run(sql, values)
    map_item(transaction_data)
  end


  def self.map_items(transaction_data)
    return transaction_data.map { |transaction| Transaction.new(transaction)  }
  end


  def self.map_item(transaction_data)
    result = Transaction.map_items(transaction_data)
    return result.first
  end

# --------------------------------------------
# ********************************************
  def self.total
    # sql = "SELECT SUM(amount)
    # FROM transactions;"
    # transaction_data = SqlRunner.run(sql)
    # map_item(transaction_data)
    transactions = self.all
    return transactions.reduce(0) { |sum, transaction| sum + transaction.amount }
  end



# instance functions ---------
  def save()
    sql = "INSERT INTO transactions
    (
      transaction_type,
      amount,
      transaction_date,
      tag_id,
      merchant_id,
      wallet_id
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6
    )
    RETURNING *;"
    values = [@transaction_type, @amount, @transaction_date, @tag_id, @merchant_id, @wallet_id]
    transaction = SqlRunner.run(sql, values)
    @id = transaction.first()['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
    SET
    (
      transaction_type,
      amount,
      transaction_date,
      tag_id,
      merchant_id,
      wallet_id
    ) =
    (
      $1, $2, $3, $4, $5, $6
    )
    WHERE id = $7"
    values = [@transaction_type, @amount, @transaction_date, @tag_id, @merchant_id, @wallet_id, @id]
    SqlRunner.run( sql, values )
  end


  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run( sql, values )
  end


  def shop_name
    sql ="SELECT merchants.*
    FROM merchants
    INNER JOIN transactions
    ON transactions.merchant_id = merchants.id
    WHERE transactions.merchant_id = $1;"
    values = [@merchant_id]
    merchant_data = SqlRunner.run( sql, values )

    result = merchant_data.map { |merchant| Merchant.new(merchant) }
    merchant = result.first
    return merchant.merchant_name
  end


  def tag_name
    sql ="SELECT tags.*
    FROM tags
    INNER JOIN transactions
    ON transactions.tag_id = tags.id
    WHERE transactions.tag_id = $1;"
    values = [@tag_id]
    tag_data = SqlRunner.run( sql, values )
    result = tag_data.map { |tag| Tag.new(tag) }
    return result.first.tag_name
  end



end
