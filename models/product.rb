require_relative("../db/sql_runner.rb")

class Product

  attr_accessor :name, :type, :description, :quantity, :buying_cost, :selling_price
  attr_reader :id, :manufacturer_id

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
    @type = options["type"].to_i
    @description = options["description"]
    @quantity = options["quantity"].to_i
    @buying_cost = options["buying_cost"]
    @selling_price = options["selling_price"]
    @manufacturer_id = options["manufacturer_id"].to_i
  end

  def save()
    sql = "
    INSERT INTO products
    (name, type, description, quantity, buying_cost, selling_price, manufacturer_id)
    VALUES($1, $2, $3, $4, $5, $6, $7)
    RETURNING id
    "
    values = [@name, @type, @description, @quantity, @buying_cost, @selling_price, @manufacturer_id]

    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def manufacturer()
    return Manufacturer.find(@manufacturer_id)
  end

  def type()
    return Type.find(@type)
  end

  def self.all()
    sql = "SELECT * FROM products"
    result = SqlRunner.run(sql)

    products = result.map{|product| Product.new(product)}

    return products
  end


  def self.delete_all
    sql = "DELETE FROM products"

    SqlRunner.run(sql)
  end

  # def delete()
  #   sql = "DELETE FROM products WHERE id = $1"
  #   values = [@id]
  #   SqlRunner.run(sql, values)
  # end

  def self.delete(id)
    sql = "DELETE FROM products WHERE id = $1"
    values = [id]

    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "
    SELECT * FROM products WHERE id = $1"
    values = [id]

    result = SqlRunner.run(sql, values)
    product = Product.new(result[0])

    return product
  end

  def update()
    sql = "UPDATE products
    SET (name, type, description, quantity, buying_cost, selling_price, manufacturer_id) = ($1, $2, $3, $4, $5, $6, $7)
    WHERE id = $8"

    values = [@name, @type, @description, @quantity, @buying_cost, @selling_price, @manufacturer_id, @id]

    SqlRunner.run(sql, values)
  end


  # def stock()
  #   sql = "SELECT products.quantity"
  #
  #
  # end

  def self.by_manufacturer(id)
    sql = "
    SELECT * FROM products
    where manufacturer_id = $1"
    value = [id]

    result = SqlRunner.run(sql, value)

    manufacturers = result.map{|manufacturer| Product.new(manufacturer)}

    return manufacturers
  end

  def self.by_type(id)
    sql = "
    SELECT * FROM products
    where type = $1"
    value = [id]

    result = SqlRunner.run(sql, value)

    types = result.map{|type| Product.new(type)}

    return types
  end


  def self.by_name(input)
    array = []
    list = Product.all()

    for product in list
      if product.name == input
        array.push(product)
      end
    end

    return array
  end


  def self.low_stock(product)
    stock = []
    notified = []

    stock.push(product) unless stock.include?(product)
    notified.push(product) unless stock.include?(product)

    Email.notification(product) unless notified.include?(product)
  end




















end
