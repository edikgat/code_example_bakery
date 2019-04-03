# frozen_string_literal: true

module BakeryApp
  class OrdersController < BaseController
    def self.show(order)
      catch_exeptions do
        OrderView.render(order)
      end
    end

    def self.create(shop, line)
      catch_exeptions do
        order = OrderCreator.create(shop: shop, params: Hash[*line.split].invert)
        show(order)
      end
    end
  end
end
