# frozen_string_literal: true

describe BakeryApp::OrderView do
  subject(:view) { described_class.new(order) }

  let(:order) { BakeryApp::Order.new(shop: shop) }
  let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
  let(:good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop) }
  let(:first_package) { BakeryApp::GoodPackage.new(good: good, weight: 3, price: 6.99) }
  let(:second_package) { BakeryApp::GoodPackage.new(good: good, weight: 5, price: 8.99) }
  let!(:first_item) { BakeryApp::OrderItem.new(order: order, count: 1, good_package: first_package) }
  let!(:second_item) { BakeryApp::OrderItem.new(order: order, count: 2, good_package: second_package) }

  describe '#content' do
    it do
      expect(subject.content).to eql("_____Check_____\n13 " \
                                     "VS5 $24.97\n     1 x 3 $6.99\n     " \
                                     "2 x 5 $8.99\n_______________\n" \
                                     "Total Price: $24.97\n")
    end
  end
end
