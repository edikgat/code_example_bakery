# frozen_string_literal: true

describe BakeryApp::OrdersController do
  describe '#show' do
    let(:order) { BakeryApp::Order.new(shop: shop) }
    let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
    let(:good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop) }
    let(:first_package) { BakeryApp::GoodPackage.new(good: good, weight: 3, price: 6.99) }
    let(:second_package) { BakeryApp::GoodPackage.new(good: good, weight: 5, price: 8.99) }
    let!(:first_item) { BakeryApp::OrderItem.new(order: order, count: 1, good_package: first_package) }
    let!(:second_item) { BakeryApp::OrderItem.new(order: order, count: 2, good_package: second_package) }
    let(:view) { BakeryApp::OrderView.new(order) }

    it 'return context from view' do
      expect(STDOUT).to receive(:puts).with(view.content)
      described_class.show(order)
    end
  end

  describe '#create' do
    context 'valid line' do
      let(:line) { '10 VS5 14 MB11 13 CF' }
      let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }

      it 'send correct params' do
        expect(BakeryApp::OrderCreator)
          .to receive(:create).with(shop: shop,
                                    params: { 'VS5' => '10', 'MB11' => '14', 'CF' => '13' })
                              .and_return('order')
        expect(described_class)
          .to receive(:show).with('order')
        described_class.create(shop, line)
      end
    end

    context 'invalid line' do
      let(:line) { 'invalid' }
      let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }

      it 'show error' do
        expect(STDOUT).to receive(:puts).with('ArgumentError odd number of arguments for Hash')
        described_class.create(shop, line)
      end
    end
  end
end
