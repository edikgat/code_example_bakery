# frozen_string_literal: true

module BakeryApp
  class GoodsPerPackagesCalculator
    attr_reader :total_count, :available_packages

    def self.calculate(available_packages:, total_count:)
      new(available_packages: available_packages,
          total_count: total_count).calculate
    end

    def initialize(available_packages:, total_count:)
      @available_packages = available_packages.sort
      @total_count = total_count
    end

    def calculate
      search = proc do |solution, current_count, package_index|
        pack = available_packages[package_index]
        pack_count, remaining_packs = current_count.divmod(pack)
        if remaining_packs.zero?
          solution[pack] = pack_count
          # return from 'calculate' method
          return solution
        elsif package_index.positive?
          pack_count.downto(0) do |i|
            if i.positive?
              solution[pack] = i
            else
              solution.delete(pack)
            end
            search[solution, current_count - i * pack, package_index - 1]
          end
          nil
        end
      end
      search[{}, total_count, available_packages.size - 1]
    end
  end
end
