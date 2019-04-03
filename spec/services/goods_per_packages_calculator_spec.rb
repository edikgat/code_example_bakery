# frozen_string_literal: true

describe BakeryApp::GoodsPerPackagesCalculator do
  subject(:calculator) do
    described_class.new(available_packages: available_packages,
                        total_count: total_count)
  end

  let(:available_packages) { [5, 10, 3] }
  let(:total_count) { 78 }

  describe '#available_packages' do
    it 'sort asc' do
      expect(subject.available_packages).to eql([3, 5, 10])
    end
  end

  describe '#calculate' do
    context 'valid' do
      it { expect(subject.calculate).to eql(10 => 7, 5 => 1, 3 => 1) }

      context 'big total count' do
        let(:total_count) { 789_556 }

        it { expect(subject.calculate).to eql(10 => 78_955, 3 => 2) }
      end
    end

    context 'less than minimum count' do
      let(:total_count) { 2 }

      it { expect(subject.calculate).to be(nil) }
    end

    context 'less than minimum count' do
      let(:total_count) { 2 }

      it { expect(subject.calculate).to be(nil) }
    end
  end
end
