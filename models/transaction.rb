require( 'pry-byebug' )
require_relative('../db/sql_runner')

class Transaction

  attr_reader :id
  attr_accessor :transaction_type, :amount, :transaction_date, :tag_id, :merchant_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @transaction_type = options['transaction_type']
    @amount = options['amount'].to_f
    @transaction_date = options['transaction_date']
    @merchant_id = options['merchant_id']
    @tag_id = options['tag_id']
  end

  def save()
    sql = "INSERT INTO transactions
    (
      transaction_type,
      amount,
      transaction_date,
      tag_id,
      merchant_id
    )
    VALUES
    (
      $1, $2, $3, $4, $5
    )
    RETURNING *;"
    values = [@transaction_type, @amount, @transaction_date, @tag_id, @merchant_id]
    transaction = SqlRunner.run(sql, values)
    @id = transaction.first()['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end





end
