# frozen_string_literal: true

module BakeryApp
  InvalidSum = Class.new(Error)
  InvalidCount = Class.new(Error)
  NoPackages = Class.new(Error)

  class OrderItemsCreator
    attr_reader :order, :good, :goods_count

    def self.create(order:, good:, goods_count:)
      new(order: order, good: good, goods_count: goods_count).create
    end

    def initialize(order:, good:, goods_count:)
      @order = order
      @good = good
      @goods_count = Integer(goods_count)
    end

    def create
      !goods_count.positive? &&
        raise(InvalidCount, 'should be positive')

      available_package_weights.empty? &&
        raise(NoPackages, 'no packages for such good')

      package_counts.nil? &&
        raise(InvalidSum, 'invalid goods count, enter another count')

      package_counts.each do |package_weight, package_count|
        package = good.packages.find { |pack| pack.weight == package_weight }
        OrderItem.new(order: order,
                      count: package_count,
                      good_package: package)
      end
    end

    def package_counts
      @package_counts ||=
        GoodsPerPackagesCalculator
        .calculate(available_packages: available_package_weights,
                   total_count: goods_count)
    end

    def available_package_weights
      @available_package_weights ||= good.packages.map(&:weight)
    end
  end
end
