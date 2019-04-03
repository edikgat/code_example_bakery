# frozen_string_literal: true

require_relative '../lib/bakery_app'

module BakeryApp
  def self.setup_shop
    shop = Shop.new(name: 'Bakery')
    Good.new(name: 'Vegemite Scroll', code: 'VS5', shop: shop).tap do |g|
      GoodPackage.new(good: g, weight: 3, price: 6.99)
      GoodPackage.new(good: g, weight: 5, price: 8.99)
    end
    Good.new(name: 'Blueberry Muffin', code: 'MB11', shop: shop).tap do |g|
      GoodPackage.new(good: g, weight: 2, price: 9.95)
      GoodPackage.new(good: g, weight: 5, price: 16.95)
      GoodPackage.new(good: g, weight: 8, price: 24.95)
    end
    Good.new(name: 'Croissant', code: 'CF', shop: shop).tap do |g|
      GoodPackage.new(good: g, weight: 3, price: 5.95)
      GoodPackage.new(good: g, weight: 5, price: 9.95)
      GoodPackage.new(good: g, weight: 9, price: 16.95)
    end
    shop
  end
end

shop = BakeryApp.setup_shop

BakeryApp::ShopsController.show(shop)

ARGF.each do |line|
  BakeryApp::OrdersController.create(shop, line)
end
