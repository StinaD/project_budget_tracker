require( 'pry-byebug' )
require_relative('../db/sql_runner')

class Tag

attr_reader :id
attr_accessor :tag_name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @tag_name = options['tag_name']
  end


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

  def Tag.delete_all
    sql = "DELETE FROM tags;"
    SqlRunner.run( sql )
  end 


end
