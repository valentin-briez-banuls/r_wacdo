class CollaborateursController < ApplicationController
  before_action :authenticate_collaborateur!
  before_action :check_admin

  def index
    @collaborateurs = Collaborateur.all
  end

  def new
    @collaborateur = Collaborateur.new
  end
  def show
    @collaborateur = Collaborateur.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to collaborateurs_path, alert: "Collaborateur introuvable."
  end
  def create
    @collaborateur = Collaborateur.new(collaborateur_params)
    if @collaborateur.save
      redirect_to @collaborateur, notice: "Collaborateur créé avec succès."
    else
      render :new
    end
  end

  private

  def collaborateur_params
    params.require(:collaborateur).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end

  def check_admin
    redirect_to root_path, alert: "Accès refusé." unless current_collaborateur&.admin?
  end
end
