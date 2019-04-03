# frozen_string_literal: true

require 'bigdecimal'
require 'pry'
require_relative './bakery_app/errors'
require_relative './bakery_app/models/base_model'
require_relative './bakery_app/models/shop'
require_relative './bakery_app/models/good'
require_relative './bakery_app/models/good_package'
require_relative './bakery_app/models/order'
require_relative './bakery_app/models/order_item'
require_relative './bakery_app/services/order_creator'
require_relative './bakery_app/services/goods_per_packages_calculator'
require_relative './bakery_app/services/order_items_creator'
require_relative './bakery_app/controllers/base_controller'
require_relative './bakery_app/controllers/orders_controller'
require_relative './bakery_app/controllers/shops_controller'
require_relative './bakery_app/views/base_view'
require_relative './bakery_app/views/order_view'
require_relative './bakery_app/views/shop_view'
require_relative './bakery_app/views/exception_view'

module BakeryApp
end
