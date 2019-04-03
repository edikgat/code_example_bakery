# frozen_string_literal: true

module BakeryApp
  InvalidPackage = Class.new(Error)

  class Good < BaseModel
    attr_reader :name, :code, :shop

    def initialize(name:, code:, shop:)
      @name = name
      @code = code
      @shop = shop
      add_good_to_shop
    end

    def packages
      @packages ||= []
    end

    def hash
      shop.hash + code.hash
    end

    def add_package(package)
      !package.is_a?(GoodPackage) &&
        raise(InvalidPackage, 'invalid class')

      package.weight.negative? &&
        raise(InvalidPackage, 'should have positive weight')

      package.price.negative? &&
        raise(InvalidPackage, 'should have positive price')

      packages.map(&:weight).include?(package.weight) &&
        raise(InvalidPackage, 'weight already exists')

      packages << package
    end

    private

    def add_good_to_shop
      shop.add_good(self)
    end
  end
end
