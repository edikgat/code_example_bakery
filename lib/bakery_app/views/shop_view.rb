# frozen_string_literal: true

module BakeryApp
  class ShopView < BaseView
    def self.render(shop)
      new(shop).render
    end

    attr_reader :shop

    def initialize(shop)
      @shop = shop
    end

    def content
      "Welcome to #{shop.name}!\n\n" \
      "Our products:\n" \
      "Name | Code | Quantity Per Pack | Price\n" \
      "#{packages_str}" \
      "#{instruction}"
    end

    private

    def packages_str
      shop.goods.inject('') do |str, good|
        str + good.packages.inject('') do |pack_str, package|
          pack_str +
            "#{good.name} | #{good.code} | " \
            "#{package.weight} | #{package.price.to_f}\n"
        end
      end
    end

    def instruction
      'Write Space Separated String That Contains Product ' \
      "Counts and Product Codes\n" \
      'For Example: "10 VS5 14 MB11 13 CF"'
    end
  end
end
