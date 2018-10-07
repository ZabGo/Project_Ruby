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

  def delete()
    sql = "DELETE FROM products WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "
    SELECT * FROM products WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return product = Product.new(result[0])
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

  def self.by_manufacturer_asc()
    sql = "
    SELECT products.id, products.name AS product, manufacturers.name AS Manufacturers, products.type, products.quantity FROM products
    INNER JOIN manufacturers
    ON manufacturers.id = products.manufacturer_id
    ORDER BY manufacturer.name ASC;"
  end

  def self.by_manufacturer_desc()
    sql = "
    SELECT products.id, products.name AS product, manufacturers.name AS Manufacturers, products.type, products.quantity FROM products
    INNER JOIN manufacturers
    ON manufacturers.id = products.manufacturer_id
    ORDER BY products.quantity DESC;"
  end
























end
