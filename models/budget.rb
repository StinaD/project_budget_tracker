require 'date'
require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative('transaction')

class Budget

  attr_reader :id
  attr_accessor :budget_name, :budget_amount, :budget_start_date, :budget_end_date

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @budget_name = options['budget_name']
    @budget_amount = options['budget_amount'].to_f
    @budget_start_date = options['budget_start_date']
    @budget_end_date = options['budget_end_date']
  end

# class functions ------------
  def self.delete_all
    sql = "DELETE FROM budget"
    SqlRunner.run( sql )
  end


  def self.all
    sql = "SELECT * FROM budget"
    budget_data = SqlRunner.run(sql)
    budget = map_items(budget_data)
    return budget
  end

  def self.find(id)
    sql = "SELECT * FROM budget
    WHERE id = $1"
    values = [id]
    budget_data = SqlRunner.run(sql, values)
    map_item(budget_data)
  end


  def self.map_items(budget_data)
    return budget_data.map { |budget| Budget.new(budget)  }
  end


  def self.map_item(budget_data)
    result = Budget.map_items(budget_data)
    return result.first
  end

# instance functions ---------

  def save()
    sql = "INSERT INTO budget
    (
      budget_name,
      budget_amount,
      budget_start_date,
      budget_end_date
    )
    VALUES
    (
      $1, $2, $3, $4
      )
    RETURNING *"
    values = [@budget_name, @budget_amount, @budget_start_date, @budget_end_date]
    budget = SqlRunner.run(sql, values)
    @id = budget.first()['id'].to_i
  end


  def update()
    sql = "UPDATE budget
    SET
    (
      budget_name,
      budget_amount,
      budget_start_date,
      budget_end_date
      ) =
    (
      $1, $2, $3, $4
      )
    where id = $5"
    values = [@budget_name, @budget_amount, @budget_start_date, @budget_end_date, @id]
    p values
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
    total_days = end_date - start_date + 1
    total_days.to_i
  end

  def budget_total_spend
    transactions = budget_transactions
    total_spend = transactions.reduce(0) { |sum, transaction| sum + transaction.amount }
    return total_spend
  end

  def remaining_budget
    spend = budget_total_spend
    return @budget_amount - spend
  end

  def budget_overspend_warning
    warning_limit = @budget_amount / 4
    remaining = remaining_budget
    days = number_of_days_remaining
    if remaining <= warning_limit && remaining > 0
      return "Warning, you have less than a quarter of your £#{@budget_amount}0 budget remaining and #{days} days left for this budget period. It might be time to restrict your spending or reconsider your budget amount."
    elsif remaining > warning_limit
      return "You have £#{remaining}0 remaining from your budget of £#{@budget_amount}0 and #{days} days left to spend or save."
    else
      return "You have overspent your budget. Your budget was £#{@budget_amount}0 but you have spent £#{budget_total_spend}0."
    end
  end


  def budget_transactions()
    sql = "SELECT transactions.*
    FROM transactions
    INNER JOIN budget
    ON transactions.budget_id = budget.id
    AND transactions.transaction_date >= budget.budget_start_date
    AND transactions.transaction_date <= budget.budget_end_date
    WHERE budget.id = $1;"
    values = [@id]
    transaction_data = SqlRunner.run(sql, values)
    transactions =  transaction_data.map { |transaction| Transaction.new(transaction)  }
    return transactions
  end


  def budget_transactions_sort_by_date_newest()
    sql = "SELECT transactions.*
    FROM transactions
    INNER JOIN budget
    ON transactions.budget_id = budget.id
    AND transactions.transaction_date >= budget.budget_start_date
    AND transactions.transaction_date <= budget.budget_end_date
    WHERE budget.id = $1
    ORDER by transaction_date DESC;"
    values = [@id]
    transaction_data = SqlRunner.run(sql, values)
    transactions =  transaction_data.map { |transaction| Transaction.new(transaction)  }
    return transactions
  end

  def budget_transactions_sort_by_date_oldest()
    sql = "SELECT transactions.*
    FROM transactions
    INNER JOIN budget
    ON transactions.budget_id = budget.id
    AND transactions.transaction_date >= budget.budget_start_date
    AND transactions.transaction_date <= budget.budget_end_date
    WHERE budget.id = $1
    ORDER by transaction_date ASC;"
    values = [@id]
    transaction_data = SqlRunner.run(sql, values)
    transactions =  transaction_data.map { |transaction| Transaction.new(transaction)  }
    return transactions
  end

  def budget_transactions_sort_by_type
    sql = "SELECT transactions.*
    FROM transactions
    INNER JOIN budget
    ON transactions.budget_id = budget.id
    AND transactions.transaction_date >= budget.budget_start_date
    AND transactions.transaction_date <= budget.budget_end_date
    WHERE budget.id = $1
    ORDER by transaction_type ASC;"
    values = [@id]
    transaction_data = SqlRunner.run(sql, values)
    transactions =  transaction_data.map { |transaction| Transaction.new(transaction) }
    return transactions
  end

  def budget_transactions_sort_by_tag
    sql = "SELECT transactions.*
    FROM transactions
    INNER JOIN budget
    ON transactions.budget_id = budget.id
    AND transactions.transaction_date >= budget.budget_start_date
    AND transactions.transaction_date <= budget.budget_end_date
    INNER JOIN tags
    ON transactions.tag_id = tags.id
    WHERE budget.id = $1
    ORDER by tag_name ASC;"
    values = [@id]
    transaction_data = SqlRunner.run(sql, values)
    transactions =  transaction_data.map { |transaction| Transaction.new(transaction) }
    return transactions
  end

  def budget_transactions_sort_by_merchant
    sql = "SELECT transactions.*
    FROM transactions
    INNER JOIN budget
    ON transactions.budget_id = budget.id
    AND transactions.transaction_date >= budget.budget_start_date
    AND transactions.transaction_date <= budget.budget_end_date
    INNER JOIN merchants
    ON transactions.merchant_id = merchants.id
    WHERE budget.id = $1
    ORDER by merchant_name ASC;"
    values = [@id]
    transaction_data = SqlRunner.run(sql, values)
    transactions =  transaction_data.map { |transaction| Transaction.new(transaction) }
    return transactions
  end


  def transactions_sort_by(input)
    result = case input
    when "type"
      budget_transactions_sort_by_type
    when "tag"
      budget_transactions_sort_by_tag
    when "merchant"
      budget_transactions_sort_by_merchant
    when "date_oldest"
      budget_transactions_sort_by_date_oldest
    else
      budget_transactions_sort_by_date_newest
    end
    return result
  end



end
