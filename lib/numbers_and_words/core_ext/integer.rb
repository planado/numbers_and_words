# frozen_string_literal: true

module NumbersAndWords
  module Extensions
    refine ::Integer do
      def to_words(options = {})
        NumbersAndWords::Wrappers::Integer.new(self).to_words(options)
      end
    end
  end
end
