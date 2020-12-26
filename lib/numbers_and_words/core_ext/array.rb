# frozen_string_literal: true

module NumbersAndWords
  module Extensions
    using Extensions

    refine ::Array do
      def to_words(options = {})
        map { |e| e.to_words(options) }
      end
    end
  end
end
