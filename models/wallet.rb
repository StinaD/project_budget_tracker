require 'date'
require( 'pry-byebug' )
require_relative('../db/sql_runner')

class Wallet

  attr_reader :id
  attr_accessor :cash_balance, :budget_amount, :budget_start_date, :budget_end_date

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @cash_balance = options['cash_balance']
    @budget_amount = options['budget_amount']
    @budget_start_date = options['budget_start_date']
    @budget_end_date = options['budget_end_date']
  end

# class functions ------------
  def self.delete_all
    sql = "DELETE FROM wallet"
    SqlRunner.run( sql )
  end


  def self.all
    sql = "SELECT * FROM wallet"
    wallet_data = SqlRunner.run(sql)
    wallet = map_items(wallet_data)
    return wallet
  end


  def self.map_items(wallet_data)
    return wallet_data.map { |wallet| Wallet.new(wallet)  }
  end


  def self.map_item(wallet_data)
    result = Wallet.map_items(wallet_data)
    return result.first
  end

# instance functions ---------

  def save()
    sql = "INSERT INTO Wallet
    (
      cash_balance,
      budget_amount,
      budget_start_date,
      budget_end_date
    )
    VALUES
    (
      $1, $2, $3, $4
      )
    RETURNING *"
    values = [@cash_balance, @budget_amount, @budget_start_date, @budget_end_date]
    wallet = SqlRunner.run(sql, values)
    @id = wallet.first()['id'].to_i
  end


  def update()
    sql = "UPDATE wallet
    SET
    (
      cash_balance,
      budget_amount,
      budget_start_date,
      budget_end_date
      ) =
    (
      $1, $2, $3, $4
      )
    where id = $5"
    values = [@cash_balance, @budget_amount, @budget_start_date, @budget_end_date, @id]
    SqlRunner.run( sql, values )
  end


  def number_of_days_spent()
    today = Date.today
    start_date = Date.parse(@budget_start_date)
    days_passed = today - start_date
    return days_passed.to_i
  end

  def number_of_days_remaining()
    today = Date.today
    end_date = Date.parse(@budget_end_date)
    days_remaining = end_date - today
    return days_remaining.to_i
  end

  def number_of_days_in_budget()
    start_date = Date.parse(@budget_start_date)
    end_date = Date.parse(@budget_end_date)
    total_days = end_date - start_date
    total_days.to_i
  end




end
