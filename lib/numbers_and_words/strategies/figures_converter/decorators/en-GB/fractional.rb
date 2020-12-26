# frozen_string_literal: true

require 'numbers_and_words/core_ext'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module EnGb
          class Fractional < En::Fractional
            using Extensions

            SHIFT_ZERO_LENGTH = 1

            def run
              fraction_to_digits
            end

            private

            def fraction_to_digits
              full_fraction.map(&:to_words).join(' ')
            end

            def zero_length
              super - SHIFT_ZERO_LENGTH
            end
          end
        end
      end
    end
  end
end
