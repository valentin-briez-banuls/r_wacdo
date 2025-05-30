class SessionsController < ApplicationController
  def new
    # juste la page de login
  end

  def create
    collaborateur = Collaborateur.find_by(email: params[:email])
    if collaborateur&.authenticate(params[:password]) && collaborateur.can_access
      session[:collaborateur_id] = collaborateur.id
      redirect_to root_path, notice: "Bienvenue, #{collaborateur.first_name} !", status: :see_other
    else
      flash.now[:alert] = "Email ou mot de passe incorrect, ou accès non autorisé"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:collaborateur_id] = nil
    redirect_to login_path, notice: "Déconnexion réussie", status: :see_other
  end
end
