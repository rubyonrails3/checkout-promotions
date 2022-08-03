require 'spec_helper'
require_relative '../../lib/cart/product'
require_relative '../../lib/cart/promotional_rules/count_based'

module PromotionalRules
  RSpec.describe CountBased do
    let(:product1) { Product.new(code: 001, name: 'Lavender heart', price: 9.25) }
    let(:product2) { Product.new(code: 002, name: 'Personalised cufflinks', price: 45.0) }
    let(:product3) { Product.new(code: 003, name: 'Kids T-shirt', price: 19.95) }
    let(:instance) { described_class.new(product_code: 001, discounted_amount: 8.5, min_products: 2) }
    context '#applies?' do
      context 'when no duplicate products are added to the cart' do
        subject { instance.applies?([product1, product2]) }
        it { is_expected.to be_falsey }
      end

      context 'when duplicate products are added to the cart' do
        subject { instance.applies?([product1, product1]) }
        it { is_expected.to be_truthy }
      end
    end

    context '#total' do
      context 'when no duplicate products are added to the cart' do
        before { instance.applies?([product1, product2]) }
        subject { instance.total }
        it { is_expected.to eq product1.price }
      end

      context 'when duplicate products are added to the cart' do
        before { instance.applies?([product1, product1]) }
        subject { instance.total }
        it { is_expected.to eq 17.0 }
      end
    end
  end
end
