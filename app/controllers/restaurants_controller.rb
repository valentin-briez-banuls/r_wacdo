class RestaurantsController < ApplicationController
  before_action :authenticate_collaborateur!
  before_action :check_admin

  def index
    @q = Restaurant.ransack(params[:q])
    @restaurants = @q.result(distinct: true)
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
    @affectations = @restaurant.affectations.includes(:collaborateur, :fonction)
  end


  def edit
    @restaurant = Restaurant.find(params[:id])
  end
  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant mis à jour.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.affectations.exists?
      redirect_to restaurants_path, alert: "Impossible de supprimer ce restaurant car des affectations y sont liées."
    else
      @restaurant.destroy
      redirect_to restaurants_path, notice: "Restaurant supprimé avec succès."
    end
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
