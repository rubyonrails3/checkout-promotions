require_relative 'base'

module PromotionalRules
  class PercentageBased < Base
    attr_reader :items, :rules, :total_amount, :discount_on, :discount_percentage
    def initialize(discount_on:, discount_percentage:)
      @discount_on = discount_on
      @discount_percentage = discount_percentage
      @total_amount = 0
    end

    def applies?(items, rules = [])
      @rules = rules
      @items = items - rules.flat_map { |rule| rule.items }
      discount_to_apply = self.items.reduce(0) { |sum, item| sum += item.price }
      @total_amount = discount_to_apply += rules.map(&:total).sum
      total_amount >= discount_on
    end

    def total
      if applies?(items, rules)
        total_amount - (discount_percentage / 100 * total_amount)
      else
        total_amount
      end
    end

    def product_base?
      false
    end
  end
end
