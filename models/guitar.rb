require_relative("../db/sql_runner.rb")
require_relative("../models/product.rb")

class Guitar

  attr_accessor :name, :pickup_id, :bridge_id, :string_id
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
    @pickup_id = options["pickup_id"].to_i
    @bridge_id = options["bridge_id"].to_i
    @string_id = options["string_id"].to_i
  end

  def save()
    sql = "
    INSERT INTO guitars
    (name, pickup_id, bridge_id, string_id)
    VALUES($1, $2, $3, $4)
    RETURNING id
    "
    values = [@name, @pickup_id, @bridge_id, @string_id]

    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM guitars"
    result = SqlRunner.run(sql)

    guitars = result.map{|guitar| Guitar.new(guitar)}

    return guitars
  end


  def self.delete_all
    sql = "DELETE FROM guitars"

    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM guitars WHERE id = $1"
    values = [id]

    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "
    SELECT * FROM guitars WHERE id = $1"
    values = [id]

    result = SqlRunner.run(sql, values)
    guitar = Guitar.new(result[0])

    return guitar
  end

  def update()
    sql = "UPDATE guitars
    SET (name, pickup_id, bridge_id, string_id) = ($1, $2, $3, $4)
    WHERE id = $5"

    values = [@name, @pickup_id, @bridge_id, @string_id, @id]

    SqlRunner.run(sql, values)
  end























end
