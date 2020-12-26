# frozen_string_literal: true

module NumbersAndWords
  module Wrappers
    class Integer
      attr_accessor :number

      def initialize(number)
        @number = number
      end

      def to_words(options = {})
        to_figures_array.to_words options
      end

      private

      def to_figures_array
        FiguresArray.new(number.to_s.chars.map(&:to_i))
      end
    end
  end
end
