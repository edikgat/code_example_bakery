# frozen_string_literal: true

module BakeryApp
  class OrderView < BaseView
    def self.render(order)
      new(order).render
    end

    attr_reader :order

    def initialize(order)
      @order = order
    end

    def content
      "_____Check_____\n" +
        items_check +
        total_check
    end

    private

    def items_check
      order.items.group_by(&:good).inject('') do |str, (good, items)|
        str + good_status_str(good, items) +
          items.inject('') { |r, item| r + item_status_str(item) }
      end
    end

    def good_status_str(good, items)
      "#{items.sum(&:goods_count)} #{good.code} $#{items.sum(&:price).to_f}\n"
    end

    def item_status_str(item)
      "     #{item.count} x #{item.weight} $#{item.good_package_price.to_f}\n"
    end

    def total_check
      "_______________\n" \
        "Total Price: $#{order.price.to_f}\n"
    end
  end
end
