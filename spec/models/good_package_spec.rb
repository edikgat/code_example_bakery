# frozen_string_literal: true

describe BakeryApp::GoodPackage do
  subject(:package) { described_class.new(good: good, weight: weight, price: price) }

  let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
  let(:good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop) }
  let(:weight) { 3 }
  let(:price) { 6.99 }

  describe '#good' do
    it { expect(subject.good).to eql(good) }
  end

  describe '#weight' do
    it { expect(subject.weight).to be(3) }

    context 'float' do
      let(:weight) { 3.5 }

      it 'force use integers' do
        expect(subject.weight).to be(3)
      end
    end

    context 'incorrect weight' do
      let(:weight) { 'incorrect' }

      it 'raises an exception if the weight is invalid' do
        expect { subject }
          .to raise_exception(ArgumentError)
      end
    end
  end

  describe '#price' do
    it 'uses BigDecimal for price' do
      expect(subject.price.class).to eql(BigDecimal)
    end

    context 'incorrect price' do
      let(:price) { 'incorrect' }

      it 'raises an exception if the weight is invalid' do
        expect { subject }
          .to raise_exception(ArgumentError)
      end
    end
  end
end
