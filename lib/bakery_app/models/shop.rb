# frozen_string_literal: true

module BakeryApp
  InvalidGood = Class.new(Error)

  class Shop < BaseModel
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def goods
      @goods ||= []
    end

    def add_good(good)
      !good.is_a?(Good) &&
        raise(InvalidGood, 'invalid class')

      goods.map(&:code).include?(good.code) &&
        raise(InvalidGood, 'code already exists')

      goods << good
    end
  end
end
