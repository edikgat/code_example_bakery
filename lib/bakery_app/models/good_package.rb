# frozen_string_literal: true

module BakeryApp
  class GoodPackage < BaseModel
    attr_reader :good, :weight, :price

    def initialize(good:, weight:, price:)
      @good = good
      @weight = Integer(weight)
      @price = BigDecimal(price, 5)
      add_package_to_good
    end

    private

    def add_package_to_good
      good.add_package(self)
    end
  end
end
