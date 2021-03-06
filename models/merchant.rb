require( 'pry-byebug' )
require_relative('../db/sql_runner')

class Merchant

attr_reader :id
attr_accessor :merchant_name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @merchant_name = options['merchant_name']
  end

# class functions ------------
  def self.all
    sql = "SELECT * FROM merchants
    ORDER BY merchant_name ASC;"
    merchants_data = SqlRunner.run( sql )
    result = merchants_data.map { |merchant| Merchant.new(merchant) }
    return result
  end


  def self.delete_all
    sql = "DELETE FROM merchants;"
    SqlRunner.run( sql )
  end


  def self.find(id)
    sql = "SELECT * FROM merchants
    WHERE id = $1;"
    values = [id]
    result = SqlRunner.run( sql, values )
    merchant = Merchant.new(result.first)
    return merchant
  end

  def self.delete(id)
    sql = "DELETE FROM merchants
    WHERE id = $1;"
    values = [id]
    SqlRunner.run( sql, values )
  end

# instance functions --------
  def save()
    sql = "INSERT INTO merchants
    (
      merchant_name
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@merchant_name]
    merchant = SqlRunner.run(sql, values)
    @id = merchant.first()['id'].to_i
  end


  def update()
  sql = "UPDATE merchants
  SET
  (
    merchant_name
    ) =
    (
      $1
    )
    WHERE id = $2"
    values = [@merchant_name, @id]
    SqlRunner.run( sql, values )
  end







end
