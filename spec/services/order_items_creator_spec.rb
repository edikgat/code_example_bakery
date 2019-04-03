# frozen_string_literal: true

describe BakeryApp::OrderItemsCreator do
  subject(:creator) { described_class.new(order: order, good: good, goods_count: goods_count) }

  let(:goods_count) { 13 }
  let(:order) { BakeryApp::Order.new(shop: shop) }
  let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
  let(:good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop) }
  let!(:first_package) { BakeryApp::GoodPackage.new(good: good, weight: 3, price: 6.99) }
  let!(:second_package) { BakeryApp::GoodPackage.new(good: good, weight: 5, price: 8.99) }

  describe '#available_package_weights' do
    it { expect(subject.available_package_weights).to eql([3, 5]) }
  end

  describe '#package_counts' do
    context 'has solution' do
      it { expect(subject.package_counts).to eql(5 => 2, 3 => 1) }

      context 'big count' do
        let(:goods_count) { 15_694 }

        it { expect(subject.package_counts).to eql(5 => 3137, 3 => 3) }
      end
    end

    context 'no sulution' do
      let(:goods_count) { 7 }

      it 'return nil' do
        expect(subject.package_counts).to be(nil)
      end
    end
  end

  describe '#create' do
    context 'incorrect count' do
      context 'negative' do
        let(:goods_count) { -7 }

        it 'raises an exception for incorrect count' do
          expect { subject.create }
            .to raise_exception(BakeryApp::InvalidCount)
        end
      end

      context 'zero' do
        let(:goods_count) { 0 }

        it 'raises an exception for incorrect count' do
          expect { subject.create }
            .to raise_exception(BakeryApp::InvalidCount)
        end
      end

      context 'can not parse to integer' do
        let(:goods_count) { 'error' }

        it 'raises an exception for incorrect count' do
          expect { subject.create }
            .to raise_exception(ArgumentError)
        end
      end

      context 'can not calculate' do
        let(:goods_count) { 7 }

        it 'raises an exception for incorrect count' do
          expect { subject.create }
            .to raise_exception(BakeryApp::InvalidSum)
        end
      end
    end

    context 'no packages for shop' do
      subject(:creator) { described_class.new(order: order, good: other_good, goods_count: goods_count) }

      let(:other_good) { BakeryApp::Good.new(name: 'No Pack', code: 'NO', shop: shop) }

      it 'raises an exception for incorrect count' do
        expect { subject.create }
          .to raise_exception(BakeryApp::NoPackages)
      end
    end

    context 'correct count' do
      let(:first_item) { order.items.find { |item| item.good_package == first_package } }
      let(:second_item) { order.items.find { |item| item.good_package == second_package } }

      it 'add order items to order' do
        expect { subject.create }
          .to change { order.items.count }.from(0).to(2)
      end

      it 'set correct counts for items' do
        subject.create
        expect(first_item.count).to be(1)
        expect(second_item.count).to be(2)
      end
    end
  end
end
