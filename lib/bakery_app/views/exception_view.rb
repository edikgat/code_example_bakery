# frozen_string_literal: true

module BakeryApp
  class ExceptionView < BaseView
    def self.render(exception)
      new(exception).render
    end

    attr_reader :exception

    def initialize(exception)
      @exception = exception
    end

    def content
      "#{exception.class} #{exception.message}"
    end
  end
end
