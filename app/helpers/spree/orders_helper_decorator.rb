
module Spree
  OrdersHelper.module_eval do

    # Is this line_item a variant from a product that have more than one variant in
    # the cart?
    def many_variants?(line_item)
      group_cart_by_product(line_item)[line_item.product.id].size > 1
    end

    def group_cart_by_product(line_item)
      @group_cart_by_product ||= line_item.order.line_items.group_by{|li| li.product.id}
    end

    # Is this the first variant of multiple variants of a product in the cart?
    def first_variant?(line_item)
      group_cart_by_product(line_item)[line_item.product.id].first == line_item
    end

    # Used for cycle color between products
    def alternate_color!
      if @color == ""
        @color = "alt"
      else
        #Default value
        @color = ""
      end
    end

    # Get what partial to use for the supplied line_item. 
    def partial_name(line_item)
      if many_variants?(line_item) 

        if first_variant?(line_item)
          alternate_color!
          "lineitem_master_variant" 
        else
          "lineitem_variant"
        end

      else
        alternate_color!
        "lineitem_normal"
      end
    end

    # Get the current color
    def color
      @color ||= ""
    end

  end
end

