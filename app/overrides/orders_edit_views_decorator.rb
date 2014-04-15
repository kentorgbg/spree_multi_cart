Deface::Override.new(:virtual_path => "spree/orders/_form",
                     :name => "create_cart_content_grouped_per_product",
                     :replace => "erb[loud]:contains('line_item')",
                     :text => "<%= render partial: 'cart_content', locals: {order_form: order_form} %>")
