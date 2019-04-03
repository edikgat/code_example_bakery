# frozen_string_literal: true

describe BakeryApp::OrderItem do
  subject(:item) { described_class.new(order: order, count: 2, good_package: package) }

  let(:order) { BakeryApp::Order.new(shop: shop) }
  let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
  let(:good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop) }
  let(:package) { BakeryApp::GoodPackage.new(good: good, weight: 3, price: 6.99) }

  describe '#good' do
    it { expect(subject.good).to eql(good) }
  end

  describe '#weight' do
    it { expect(subject.weight).to be(3) }
  end

  describe '#goods_count' do
    it { expect(subject.goods_count).to be(6) }
  end

  describe '#price' do
    it { expect(subject.price.to_f).to be(13.98) }
  end

  describe '#good_package_price' do
    it { expect(subject.good_package_price.to_f).to be(6.99) }
  end
end
