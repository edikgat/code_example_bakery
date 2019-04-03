# frozen_string_literal: true

describe BakeryApp::Order do
  subject(:order) { described_class.new(shop: shop) }

  let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
  let(:good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop) }
  let(:first_package) { BakeryApp::GoodPackage.new(good: good, weight: 3, price: 6.99) }
  let(:second_package) { BakeryApp::GoodPackage.new(good: good, weight: 5, price: 8.99) }
  let(:first_item) { BakeryApp::OrderItem.new(order: subject, count: 1, good_package: first_package) }
  let(:second_item) { BakeryApp::OrderItem.new(order: subject, count: 2, good_package: second_package) }

  describe '#shop' do
    it { expect(subject.shop).to eql(shop) }
  end

  describe '#items' do
    let(:other_item) do
      BakeryApp::OrderItem.new(count: 2,
                               good_package: second_package,
                               order: described_class.new(shop: shop))
    end

    it 'return items that associated to order' do
      first_item
      other_item
      expect(subject.items).to eql([first_item])
    end
  end

  describe '#price' do
    it 'calculate total price for order' do
      first_item
      second_item
      expect(order.price.to_f).to be(24.97)
    end
  end

  describe '#add_item' do
    context 'incorrect class' do
      let(:incorrect_intem) { 'incorrect' }

      it 'raises an exception if the type is invalid' do
        expect { subject.add_item(incorrect_intem) }
          .to raise_exception(BakeryApp::InvalidOrderItem)
      end
    end

    context 'item for already associated package' do
      let(:item_for_same_package) do
        BakeryApp::OrderItem.new(order: subject,
                                 count: 3,
                                 good_package: first_package)
      end

      it 'raises an exception code already exists' do
        first_item
        second_item
        expect { item_for_same_package }
          .to raise_exception(BakeryApp::InvalidOrderItem)
      end
    end

    context 'valid item' do
      it 'successfully add item to order' do
        first_item
        expect { second_item }.not_to raise_exception
      end
    end
  end
end
