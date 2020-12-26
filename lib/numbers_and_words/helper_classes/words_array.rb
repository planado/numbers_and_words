# frozen_string_literal: true

module NumbersAndWords
  class WordsArray
    attr_reader :collection

    def initialize(collection = [])
      @collection = collection
    end

    def join(options = {})
      local_language { Strategies.array_joiner.new(collection, options).run }
    end

    def local_language(&block)
      ::I18n.with_locale(I18n.local_language, &block)
    end
  end
end
