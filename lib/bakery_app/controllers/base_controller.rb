# frozen_string_literal: true

module BakeryApp
  class BaseController
    def self.catch_exeptions
      yield
    rescue StandardError => e
      ExceptionView.render(e)
    end
  end
end
