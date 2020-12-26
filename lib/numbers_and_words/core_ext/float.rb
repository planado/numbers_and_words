# frozen_string_literal: true

module NumbersAndWords
  module Extensions
    refine ::Float do
      def to_words(options = {})
        NumbersAndWords::Wrappers::Float.new(self).to_words(options)
      end
    end
  end
end
