require 'spec_helper'
require_relative '../../lib/cart/product'
require_relative '../../lib/cart/promotional_rules/percentage_based'

module PromotionalRules
  RSpec.describe PercentageBased do
    let(:product1) { Product.new(code: 001, name: 'Lavender heart', price: 9.25) }
    let(:product2) { Product.new(code: 002, name: 'Personalised cufflinks', price: 45.0) }
    let(:product3) { Product.new(code: 003, name: 'Kids T-shirt', price: 19.95) }
    let(:rules) { [] }
    let(:instance) { described_class.new(discount_on: 50.0, discount_percentage: 10.0) }
    context '#applies?' do
      context 'when it applies' do
        subject { instance.applies?([product1, product2], rules) }
        it { is_expected.to be_truthy }
      end

      context 'when it does not applies' do
        subject { instance.applies?([product1, product1], rules) }
        it { is_expected.to be_falsey }
      end
    end

    context '#total' do
      context 'when discount is applied' do
        before { instance.applies?([product1, product2], rules) }
        subject { instance.total }
        it { is_expected.to eq 48.825 }
      end

      context 'when duplicate products are added to the cart' do
        before { instance.applies?([product1, product1], rules) }
        subject { instance.total }
        it { is_expected.to eq 18.5 }
      end
    end
  end
end
