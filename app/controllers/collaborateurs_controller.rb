class CollaborateursController < ApplicationController
  before_action :authenticate_collaborateur!
  before_action :check_admin
  def index
    @q = Collaborateur.ransack(params[:q])
    @collaborateurs = @q.result
  end


  def show
    @collaborateur = Collaborateur.find(params[:id])
  end


  def new
    @collaborateur = Collaborateur.new
  end

  def create
    @collaborateur = Collaborateur.new(collaborateur_params)
    if @collaborateur.save
      redirect_to @collaborateur, notice: "Collaborateur créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @collaborateur = Collaborateur.find(params[:id])
  end


  def update
    @collaborateur = Collaborateur.find(params[:id])
    if @collaborateur.update(collaborateur_params)
      redirect_to collaborateurs_path, notice: "Collaborateur mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end



  def destroy
    @collaborateur.destroy
    redirect_to collaborateurs_path, notice: "Collaborateur supprimé."
  end

  private

  def set_collaborateur
    @collaborateur = Collaborateur.find(params[:id])
  end

  def collaborateur_params
    if params[:collaborateur][:admin] == "1"
      params.require(:collaborateur).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    else
      params.require(:collaborateur).permit(:first_name, :last_name, :email, :admin)
    end
  end



  def check_admin
    redirect_to root_path, alert: "Accès refusé." unless current_collaborateur&.admin?
  end
end
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :admin])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :admin])
  end
end
