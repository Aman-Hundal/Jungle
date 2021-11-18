class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user #to look up the user, if they're logged in, and save their user object to a variable called @current_user. 
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # saying if current_uesr is falsey/null then itll evaluate to a user object if session id exists(? wtf is that last if statement saying). Session[:user_id] is essentiaully a user.id
  end 
  helper_method :current_user #The helper_method line allows us to use @current_user in our view files and anywhere in our app
  
  def authorize #simple authorization function. Authorize is for sending someone to the login page if they aren't logged in - this is how we keep certain pages our site secure... user's have to login before seeing them.
    if !current_user
      redirect_to '/login'
    end
  end

  def soldout?
  end

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

end
