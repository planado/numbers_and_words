# frozen_string_literal: true

module NumbersAndWords
  class FiguresArray
    MICRO_CAPACITY_SHIFT = 2
    FIGURES_IN_CAPACITY = 3
    THOUSAND_CAPACITY = 1
    ONES_SHIFT = 1

    attr_reader :collection

    def initialize(collection = [])
      @collection = collection
    end

    def size
      collection.size
    end

    def to_words(options = {})
      local_language { Strategies.figures_converter.new(self, options).run }
    end

    def reverse
      new(collection.reverse)
    end

    def local_language(&block)
      ::I18n.with_locale(I18n.local_language, &block)
    end

    def capacity_length
      collection.length - ONES_SHIFT
    end

    def capacity_count
      count = capacity_length / FIGURES_IN_CAPACITY
      count.zero? ? nil : count
    end

    def figures_array_in_capacity(capacity)
      new(collection[capacity * FIGURES_IN_CAPACITY, FIGURES_IN_CAPACITY])
    end

    def number_in_capacity(capacity)
      figures_array_in_capacity(capacity).reverse.join.to_i
    end

    def number_under_capacity(capacity)
      figures_array_under_capacity(capacity).reverse.join.to_i
    end

    def opaque?(capacity)
      figures_under = figures_array_under_capacity(capacity)
      figures_under.count(0) == figures_under.length
    end

    def figures_array_under_capacity(capacity)
      collection[0..(capacity * FIGURES_IN_CAPACITY) - ONES_SHIFT]
    end

    def ones
      self[0].to_i if self[0].to_i.positive?
    end

    def teens
      tens_with_ones if tens == 1
    end

    def tens
      self[1].to_i if self[1].to_i.positive?
    end

    def tens_with_ones
      [ones, tens] if ones && tens
    end

    def hundreds
      self[2].to_i if self[2].to_i.positive?
    end

    def round_hundred?
      ones.nil? && tens.nil?
    end

    def sub_capacity
      capacity_length % FIGURES_IN_CAPACITY
    end

    def fraction_capacity
      [fraction_capacity_count, fraction_sub_capacity]
    end

    def fraction_capacity_count
      capacity_count.nil? ? sub_capacity : capacity_count + MICRO_CAPACITY_SHIFT
    end

    def fraction_sub_capacity
      sub_capacity unless capacity_count.nil?
    end

    def ordinal_index
      collection.index(&:positive?)
    end

    def ordinal_capacity
      count = ordinal_index / FIGURES_IN_CAPACITY
      count.zero? ? nil : count
    end

    def join(with = '')
      collection.join(with)
    end

    def +(other)
      new(collection + other)
    end

    def unshift(value)
      collection.unshift(value)
      self
    end

    def map(&block)
      new(collection.map(&block))
    end

    def [](*index)
      collection[*index]
    end

    def clone
      new(collection.dup)
    end

    def dup
      new(collection.dup)
    end

    def new(collection)
      FiguresArray.new(collection)
    end
  end
end
