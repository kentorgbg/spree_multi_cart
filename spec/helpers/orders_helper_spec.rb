require "spec_helper"

describe Spree::OrdersHelper do 
  context "multi cart extension" do

    context "#alternate_color!" do 
      it "should change color when alternate_color is called!" do
        alternate_color!
        expect(color).to eq ""
        
        alternate_color!
        expect(color).to eq "alt"
      end

    end

    context "#many_variants?" do
      
      before :each do
        @order = create(:order_with_line_items, :line_items_count => 1)
        @line_item = @order.line_items.first
      end      

      it "should return false when there is only one variant" do
        expect(many_variants?(@line_item)).to be false
      end
      
      it "should return true when there is two or more variants" do 
        # Add one more variant with the same product but with a different variant
        product = @line_item.product
        @order.line_items << create(:line_item, :order => @order, :product => product)

        expect(many_variants?(@line_item)).to be true
      end

    end


    context "#group_cart_by_product" do

      before :each do
        @order = create(:order_with_line_items, :line_items_count => 1)
        @line_item = @order.line_items.first
      
        # Add one more variant with the same product but with a different variant
        product = @line_item.product
        @order.line_items << create(:line_item, :order => @order, :product => product)

      end      

      let(:result) { group_cart_by_product(@line_item) }

      it "should return an hash with pruducts ids as keys and lne_items as values" do
        expect(result).to eq({@line_item.product.id => @order.line_items})
      end

    end


    context "#first_variant?" do 
      before :each do
        @order = create(:order_with_line_items, :line_items_count => 1)
        @line_item = @order.line_items.first
      
        # Add one more variant with the same product but with a different variant
        product = @line_item.product
        @order.line_items << create(:line_item, :order => @order, :product => product)
      end      

      it "should return true when a line_item is the first line_item" do
        result = first_variant?(@order.line_items.first)
        expect(result).to be true
      end

      it "should return false when a line_item is not the first line_item" do
        result = first_variant?(@order.line_items.last)
        expect(result).to be false
      end
    end

    context "#partial_name" do

      before :each do
        @order = create(:order_with_line_items, :line_items_count => 1)
        @line_item = @order.line_items.first
      end      

      it "should return the default partial when a line_item is the only variant of a product" do
        expect(partial_name(@line_item)).to eq("lineitem_normal")
      end

      it "should return the master_variant partial when a line_item is the first of mulitple variants of a product" do 

        # Add a variant
        product = @line_item.product
        @order.line_items << create(:line_item, :order => @order, :product => product)

        expect(partial_name(@line_item)).to eq("lineitem_master_variant")
      end
      
      it "should return the variant partial when a line_item is mot the first of multiple variants of a product" do 

        # Add a variant
        product = @line_item.product
        @order.line_items << create(:line_item, :order => @order, :product => product)

        expect(partial_name(@order.line_items.last)).to eq("lineitem_variant")
      end

    end

  end

end
