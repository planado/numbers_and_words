# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Ru
          class Fractional < Base
            def run
              @options[:gender] = :female
              "#{super} #{fraction_significance}"
            end

            private

            def fraction_significance
              @strategy.translations.micros full_fraction.fraction_capacity, figures.reverse.join.to_i
            end

            def full_fraction
              (0..zero_length).inject(figures.clone) { |result, _el| result.unshift '0' }
            end

            def figures
              @strategy.figures
            end

            def zero_length
              fraction_length - figures.size
            end

            def fraction_length
              @options[:fractional][:length].to_i
            end
          end
        end
      end
    end
  end
end
