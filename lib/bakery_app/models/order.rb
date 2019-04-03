# frozen_string_literal: true

module BakeryApp
  InvalidOrderItem = Class.new(Error)

  class Order < BaseModel
    attr_reader :shop

    def initialize(shop:)
      @shop = shop
    end

    def items
      @items ||= []
    end

    def price
      items.sum(&:price)
    end

    def add_item(item)
      !item.is_a?(OrderItem) &&
        raise(InvalidOrderItem, 'invalid class')

      items.map(&:good_package).include?(item.good_package) &&
        raise(InvalidOrderItem, 'package already exists')

      items << item
    end
  end
end
