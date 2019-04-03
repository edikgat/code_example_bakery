# frozen_string_literal: true

module BakeryApp
  class BaseView
    def render
      puts(content)
    end

    def content
      raise 'Not Implemented'
    end
  end
end
