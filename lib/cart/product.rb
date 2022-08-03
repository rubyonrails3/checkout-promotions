class Product
  attr_accessor :code, :price, :name
  def initialize(code:, price:, name:)
    @code = code
    @price = price
    @name = name
  end
end
