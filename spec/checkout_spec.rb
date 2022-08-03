require 'spec_helper'
require_relative '../lib/cart/product'
require_relative '../lib/cart/checkout'
require_relative '../lib/cart/promotional_rules/count_based'
require_relative '../lib/cart/promotional_rules/percentage_based'

RSpec.describe Checkout do
  let(:product1) { Product.new(code: 001, name: 'Lavender heart', price: 9.25) }
  let(:product2) { Product.new(code: 002, name: 'Personalised cufflinks', price: 45.0) }
  let(:product3) { Product.new(code: 003, name: 'Kids T-shirt', price: 19.95) }
  let(:rule1) { PromotionalRules::CountBased.new(product_code: 001, discounted_amount: 8.5, min_products: 2) }
  let(:rule2) { PromotionalRules::PercentageBased.new(discount_on: 60.0, discount_percentage: 10.0) }
  let(:rules) { [rule1, rule2] }
  context '#total' do
    let(:checkout) { Checkout.new(rules) }
    context 'when only percentage based discount is applied' do
      let(:subject) { checkout.total }
      before do
        checkout.scan(product1)
        checkout.scan(product2)
        checkout.scan(product3)
      end
      it { is_expected.to eq 66.78 }
    end

    context 'when only count base discount is applied' do
      let(:subject) { checkout.total }
      before do
        checkout.scan(product1)
        checkout.scan(product3)
        checkout.scan(product1)
      end
      it { is_expected.to eq 36.95 }
    end

    context 'when count + percentage base discount is applied' do
      let(:subject) { checkout.total }
      before do
        checkout.scan(product1)
        checkout.scan(product2)
        checkout.scan(product1)
        checkout.scan(product3)
      end
      it { is_expected.to eq 73.76 }
    end

    describe 'when percentage discount can be applied but count discount nullifies the discount on total' do
      let(:product1) { Product.new(code: 001, name: 'Lavender heart', price: 10.0) }
      let(:product2) { Product.new(code: 002, name: 'Personalised cufflinks', price: 40) }
      let(:rule1) { PromotionalRules::CountBased.new(product_code: 001, discounted_amount: 8.0, min_products: 2) }
      let(:rule2) { PromotionalRules::PercentageBased.new(discount_on: 60.0, discount_percentage: 10.0) }
      let(:rules) { [rule1, rule2] }
      let(:checkout) { Checkout.new(rules) }
      let(:subject) { checkout.total }
      before do
        checkout.scan(product1)
        checkout.scan(product2)
        checkout.scan(product1)
      end
      it { is_expected.to eq 56 }
    end
  end
end
