require( 'pry-byebug' )
require_relative('../db/sql_runner')

class Tag

attr_reader :id, :tag_name


  def initialize( options )
    @id = options['id'].to_i if options['id']
    @tag_name = options['tag_name']
  end


# class functions ---------
  def self.delete_all
    sql = "DELETE FROM tags;"
    SqlRunner.run( sql )
  end

  def self.all
    sql = "SELECT * FROM tags
    ORDER BY tag_name ASC;"
    result = SqlRunner.run( sql )
    return result.map { |tag| Tag.new(tag) }
  end

  def self.find(id)
    sql = "SELECT * FROM tags
    WHERE id = $1;"
    values = [id]
    result = SqlRunner.run( sql, values )
    tag = Tag.new(result.first)
    return tag
  end


# instance functions ------
  def save()
    sql = "INSERT INTO tags
    (
      tag_name
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@tag_name]
    merchant = SqlRunner.run(sql, values)
    @id = merchant.first()['id'].to_i
  end




end
