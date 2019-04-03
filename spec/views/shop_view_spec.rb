# frozen_string_literal: true

describe BakeryApp::ShopView do
  subject(:view) { described_class.new(shop) }

  let(:shop) { BakeryApp::Shop.new(name: 'Bakery') }
  let(:first_good) { BakeryApp::Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop) }
  let(:second_good) { BakeryApp::Good.new(name: 'Croissant', code: 'CF', shop: shop) }
  let!(:first_package) { BakeryApp::GoodPackage.new(good: first_good, weight: 3, price: 6.99) }
  let!(:second_package) { BakeryApp::GoodPackage.new(good: second_good, weight: 5, price: 8.99) }

  describe '#content' do
    it do
      expect(subject.content).to eql("Welcome to Bakery!\n\n" \
                                     "Our products:\nName | Code | " \
                                     "Quantity Per Pack | Price\n" \
                                     "Vegemite Scroll | VS5 | 3 | 6.99\n" \
                                     "Croissant | CF | 5 | 8.99\n" \
                                     'Write ' \
                                     'Space Separated String That Contains ' \
                                     "Product Counts and Product Codes\nFor " \
                                     'Example: "10 VS5 14 MB11 13 CF"')
    end
  end
end
