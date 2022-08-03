class Checkout
  attr_reader :promotional_rules, :items
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @items = []
  end

  def scan(item)
    items << item
  end

  def total
    return without_promotions_total unless promotions?

    promotions_total
  end

  private

  def promotions?
    Array(promotional_rules).any?
  end

  def without_promotions_total
    items.reduce(0) { |sum, item| sum += item.price }.round(2)
  end

  def promotions_total
    return product_based_promotions_total if total_based_rules.empty?

    total_based_rules.last.total.round(2)
  end

  def total_based_rules
    return @total_based_rules unless @total_based_rules.nil?

    @total_based_rules = promotional_rules.reject(&:product_base?).tap do |rules|
      rules.each { |rule| rule.applies?(items, product_based_rules) }
    end
  end

  def product_based_rules
    return @product_based_rules unless @product_based_rules.nil?

    @product_based_rules = promotional_rules.select(&:product_base?).tap do |rules|
      rules.each { |rule| rule.applies?(items) }
    end
  end

  def product_based_promotions_total
    @product_based_promotions_total ||= product_based_rules.reduce(0) { |sum, rule| sum += rule.total }
  end
end
