require_relative("../db/sql_runner.rb")
require("pry")

class Manufacturer

  attr_accessor :name, :address, :phone, :email
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
    @address = options["address"]
    @phone = options["phone"]
    @email = options["email"]
  end

  def save()
    sql = "
    INSERT INTO manufacturers
    (name, address, phone, email)
    VALUES($1, $2, $3, $4)
    RETURNING id
    "
    values = [@name, @address, @phone, @email]

    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM manufacturers"

    result = SqlRunner.run(sql)

    manufacturers = result.map{|manufacturer| Manufacturer.new(manufacturer)}

    return manufacturers
  end


  def self.delete_all
    sql = "DELETE FROM manufacturers"

    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM manufacturers WHERE id = $1"

    values = [id]

    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "
    SELECT * FROM manufacturers WHERE id = $1"
    values = [id]

    result = SqlRunner.run(sql, values)
    manufacturer = Manufacturer.new(result[0])
    return manufacturer
  end

  def update()
    sql = "UPDATE manufacturers
    SET (name, address, phone, email) = ($1, $2, $3, $4)
    WHERE id = $5"

    values = [@name, @address, @phone, @email, @id]

    SqlRunner.run(sql, values)
  end

  def self.by_name(input)
    x = input.to_s
    array = []
    list = Manufacturer.all()

    for manufacturer in list

      if manufacturer.name.chomp.include?(x.chomp) == true
              # binding.pry
        array.push(manufacturer)
      end
    end

    return array
  end

      # if manufacturer.name == input
      # manufacturer.name.chomp.include?(input.chomp) == true
end
