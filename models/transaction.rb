require( 'pry-byebug' )
require_relative('../db/sql_runner')

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
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end


  def self.all()
    sql = "SELECT * FROM transactions"
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







end