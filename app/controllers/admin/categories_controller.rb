class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]

  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

end

private

def category_params
  params.require(:category).permit( #this params object comes from the form_for code in new this line ->  <%= form.text_field :name, class: 'form-control' %>
    :name,
  )
end

