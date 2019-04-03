# frozen_string_literal: true

describe BakeryApp::Shop do
  subject(:shop) { described_class.new(name: name) }

  let(:name) { 'Bakery' }
  let(:first_good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: subject) }
  let(:second_good) { BakeryApp::Good.new(name: 'Croissant', code: 'CF', shop: subject) }

  describe '#name' do
    it { expect(subject.name).to eql('Bakery') }
  end

  describe '#goods' do
    let(:other_good) { BakeryApp::Good.new(name: 'Muffin', code: 'MB11', shop: described_class.new(name: 'other')) }

    it 'return goods that associated to shop' do
      first_good
      second_good
      other_good
      expect(subject.goods).to eql([first_good, second_good])
    end
  end

  describe '#add_good' do
    context 'incorrect class' do
      let(:incorrect_good) { 'incorrect' }

      it 'raises an exception if the type is invalid' do
        expect { subject.add_good(incorrect_good) }
          .to raise_exception(BakeryApp::InvalidGood)
      end
    end

    context 'good with same code already present' do
      let(:good_with_same_code) { BakeryApp::Good.new(name: 'Muffin', code: 'CF', shop: subject) }

      it 'raises an exception code already exists' do
        first_good
        second_good
        expect { good_with_same_code }
          .to raise_exception(BakeryApp::InvalidGood)
      end
    end

    context 'valid good' do
      let(:new_good) { BakeryApp::Good.new(name: 'Muffin', code: 'MB11', shop: subject) }

      it 'successfully add good to shop' do
        first_good
        second_good
        expect { new_good }.not_to raise_exception
      end
    end
  end
end
