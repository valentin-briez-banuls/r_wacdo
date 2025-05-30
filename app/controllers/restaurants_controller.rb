class RestaurantsController < ApplicationController
  before_action :authenticate_collaborateur!
  before_action :check_admin

  def index
    @restaurants = Restaurant.all
  end


  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant, notice: "Restaurant créé avec succès."
    else
      render :new
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :postal_code, :city)
  end

  def check_admin
    unless current_collaborateur&.admin?
      redirect_to root_path, alert: "Accès refusé."
    end
  end

end
