# frozen_string_literal: true

module BakeryApp
  class ShopsController < BaseController
    def self.show(shop)
      catch_exeptions do
        ShopView.render(shop)
      end
    end
  end
end
