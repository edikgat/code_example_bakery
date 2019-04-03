# frozen_string_literal: true

module BakeryApp
  class OrderItem < BaseModel
    attr_reader :order, :count, :good_package

    def initialize(order:, count:, good_package:)
      @order = order
      @count = count
      @good_package = good_package
      add_item
    end

    def good
      good_package.good
    end

    def weight
      good_package.weight
    end

    def price
      good_package.price * count
    end

    def good_package_price
      good_package.price
    end

    def goods_count
      weight * count
    end

    private

    def add_item
      order.add_item(self)
    end
  end
end
