require "spec_helper"

describe "Showing multiple variants group by product on cart page", js: true do
  
  context "No products in cart" do

    it "should show an empty cart" do
      visit spree.cart_path
      page.should have_content("Your cart is empty")
    end

  end

  context "Mutiple products in cart with only one variant per each" do
   
    before do
      @product1 = create(:product)
      @product2 = create(:product)
      @product3 = create(:product)
      
      visit spree.product_path(@product1)
      click_button "add-to-cart-button"
      
      visit spree.product_path(@product2)
      click_button "add-to-cart-button"

      visit spree.product_path(@product3)
      click_button "add-to-cart-button"
    end
  

    it "should show all products" do

      visit spree.cart_path
      
      page.should have_content("Shopping Cart")
  
      # Verify cart content - should have three products
      within("#cart-detail") do 
        page.should have_selector("tr.line-item", :count => 3)
      end

    end

    it "should cycle row colors" 

  end


end
