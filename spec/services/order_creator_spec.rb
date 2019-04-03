# frozen_string_literal: true

describe BakeryApp::OrderCreator do
  subject(:creator) { described_class.new(shop: shop, params: params) }

  let(:params) { { 'VS5' => '13', 'CF' => '13' } }
  let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
  let(:first_good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop) }
  let(:second_good) { BakeryApp::Good.new(name: 'Croissant', code: 'CF', shop: shop) }
  let!(:first_package) { BakeryApp::GoodPackage.new(good: first_good, weight: 3, price: 6.99) }
  let!(:second_package) { BakeryApp::GoodPackage.new(good: first_good, weight: 5, price: 8.99) }
  let!(:third_package) { BakeryApp::GoodPackage.new(good: second_good, weight: 1, price: 2.99) }

  describe '#create' do
    context 'incorrect good code' do
      let(:params) { { 'VSasdsads5' => '10' } }

      it 'raises an exception for incorrect code' do
        expect { subject.create }
          .to raise_exception(BakeryApp::NoGoodCode)
      end
    end

    context 'correct good codes' do
      it 'return order' do
        expect(subject.create).to be_instance_of(BakeryApp::Order)
      end

      it 'add order items to order' do
        expect(subject.create.items.count).to be(3)
      end
    end
  end
end
