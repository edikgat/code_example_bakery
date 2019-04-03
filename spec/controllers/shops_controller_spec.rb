# frozen_string_literal: true

describe BakeryApp::ShopsController do
  let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
  let(:first_good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop) }
  let(:second_good) { BakeryApp::Good.new(name: 'Croissant', code: 'CF', shop: shop) }
  let!(:first_package) { BakeryApp::GoodPackage.new(good: first_good, weight: 3, price: 6.99) }
  let!(:second_package) { BakeryApp::GoodPackage.new(good: second_good, weight: 5, price: 8.99) }
  let(:view) { BakeryApp::ShopView.new(shop) }

  describe '#show' do
    it 'return context from view' do
      expect(STDOUT).to receive(:puts).with(view.content)
      described_class.show(shop)
    end
  end
end
