require_relative("../db/sql_runner.rb")

class Type

  attr_accessor :name

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]

  end


  def save()
    sql = "
    INSERT INTO types (name)
    VALUES($1)
    RETURNING id
    "
    values = [@name]

    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM types"
    result = SqlRunner.run(sql)
    types = result.map{|types| Product.new(types)}
    return types

  end


  def self.delete_all
    sql = "DELETE FROM types"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM types WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "
    SELECT * FROM types WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return type = Type.new(result[0])
  end

  def update()
    sql = "UPDATE types
    SET name = $1
    WHERE id = $2"

    values = [@name, @id]

    SqlRunner.run(sql, values)
  end





end
