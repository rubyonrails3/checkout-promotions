require_relative 'base'

module PromotionalRules
  class CountBased < Base
    attr_reader :product_code, :discounted_amount, :min_products
    def initialize(product_code:, discounted_amount:, min_products: 1)
      @product_code = product_code
      @discounted_amount = discounted_amount
      @min_products = min_products
    end

    def applies?(items)
      matching_items(items).length >= min_products
    end

    def total
      if applies?(items)
        items.reduce(0) { |sum, item| sum += discounted_amount }
      else
        items.reduce(0) { |sum, item| sum += item.price }
      end
    end

    def matching_items(items)
      @items ||= items.select { |item| item.code == product_code }
    end

    def product_base?
      true
    end
  end
end
