# frozen_string_literal: true

module BakeryApp
  NoGoodCode = Class.new(Error)

  class OrderCreator
    attr_reader :shop, :order, :params

    def self.create(shop:, params:)
      new(shop: shop, params: params).create
    end

    def initialize(shop:, params:)
      @shop = shop
      @params = params
      @order = Order.new(shop: shop)
    end

    def create
      params.each do |good_code, goods_count|
        good = shop.goods.find { |gd| gd.code == good_code }
        raise(NoGoodCode, 'invalid good code') if good.nil?

        OrderItemsCreator.create(order: order,
                                 good: good,
                                 goods_count: goods_count)
      end
      order
    end
  end
end
