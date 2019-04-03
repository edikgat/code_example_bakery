# frozen_string_literal: true

describe BakeryApp::Good do
  subject(:good) { described_class.new(name: name, code: 'VS5', shop: shop) }

  let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
  let(:name) { 'Vegemite Scroll' }
  let(:first_package) { BakeryApp::GoodPackage.new(good: subject, weight: 3, price: 6.99) }
  let(:second_package) { BakeryApp::GoodPackage.new(good: subject, weight: 5, price: 8.99) }

  describe '#name' do
    it { expect(subject.name).to eql('Vegemite Scroll') }
  end

  describe '#code' do
    it { expect(subject.code).to eql('VS5') }
  end

  describe '#shop' do
    it { expect(subject.shop).to eql(shop) }
  end

  describe '#packages' do
    let(:other_package) do
      BakeryApp::GoodPackage.new(weight: 10,
                                 price: 100.99,
                                 good: described_class.new(name: 'other', code: 'code', shop: shop))
    end

    it 'return packages that associated to good' do
      first_package
      second_package
      other_package
      expect(subject.packages).to eql([first_package, second_package])
    end
  end

  describe '#add_package' do
    context 'incorrect class' do
      let(:incorrect_package) { 'incorrect' }

      it 'raises an exception if the type is invalid' do
        expect { subject.add_package(incorrect_package) }
          .to raise_exception(BakeryApp::InvalidPackage)
      end
    end

    context 'negative weight' do
      let(:negative_package) { BakeryApp::GoodPackage.new(good: subject, weight: -10, price: 10.99) }

      it 'raises an exception if the type is invalid' do
        expect { subject.add_package(negative_package) }
          .to raise_exception(BakeryApp::InvalidPackage)
      end
    end

    context 'zero weight' do
      let(:zero_package) { BakeryApp::GoodPackage.new(good: subject, weight: 0, price: 10.99) }

      it 'raises an exception if the type is invalid' do
        expect { subject.add_package(zero_package) }
          .to raise_exception(BakeryApp::InvalidPackage)
      end
    end

    context 'negative price' do
      let(:negative_package) { BakeryApp::GoodPackage.new(good: subject, weight: 7, price: -10.99) }

      it 'raises an exception if the type is invalid' do
        expect { subject.add_package(negative_package) }
          .to raise_exception(BakeryApp::InvalidPackage)
      end
    end

    context 'zero price' do
      let(:zero_package) { BakeryApp::GoodPackage.new(good: subject, weight: 7, price: 0) }

      it 'raises an exception if the type is invalid' do
        expect { subject.add_package(zero_package) }
          .to raise_exception(BakeryApp::InvalidPackage)
      end
    end

    context 'package with same weight already present' do
      let(:package_with_same_weight) { BakeryApp::GoodPackage.new(good: subject, weight: 5, price: 80.99) }

      it 'raises an exception weight already exists' do
        first_package
        second_package
        expect { package_with_same_weight }
          .to raise_exception(BakeryApp::InvalidPackage)
      end
    end

    context 'valid package' do
      let(:new_package) { BakeryApp::GoodPackage.new(good: subject, weight: 10, price: 10.99) }

      it 'successfully add package to good' do
        first_package
        second_package
        expect { new_package }.not_to raise_exception
      end
    end
  end
end
