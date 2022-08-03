module PromotionalRules
  class Base
    attr_reader :items

    def product_base?
      raise NotImplementedError
    end
  end
end
