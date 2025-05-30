class ApplicationController < ActionController::Base
  before_action :authenticate_collaborateur!

  def logged_in?
    collaborateur_signed_in?
  end

  def admin?
    current_collaborateur&.admin?
  end

  def require_admin
    unless logged_in? && admin?
      redirect_to new_collaborateur_session_path, alert: "Accès réservé aux administrateurs", status: :see_other
    end
  end
end
