class AffectationsController < ApplicationController
  before_action :authenticate_collaborateur!
  before_action :set_affectation, only: %i[show edit update destroy]

  def index
    @q = Affectation.ransack(params[:q])
    @affectations = @q.result.includes(:collaborateur, :restaurant, :fonction)
  end


  def show
  end

  def new
    @affectation = Affectation.new
    @affectation.restaurant_id = params[:restaurant_id] if params[:restaurant_id].present?
    @collaborateurs = Collaborateur.all
    @fonctions = Fonction.all
  end


  def create
    @affectation = Affectation.new(affectation_params)

    previous = Affectation
                 .where(collaborateur_id: @affectation.collaborateur_id)
                 .where("start_date < ?", @affectation.start_date)
                 .where(end_date: nil)
                 .order(start_date: :desc)
                 .first

    if previous
      previous.update(end_date: @affectation.start_date)
    end

    if @affectation.save
      redirect_to affectations_path, notice: "Affectation créée avec succès."
    else
      @collaborateurs = Collaborateur.all
      @fonctions = Fonction.all
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @collaborateurs = Collaborateur.all
    @fonctions = Fonction.all
  end

  def update
    if @affectation.update(affectation_params)
      redirect_to affectations_path, notice: "Affectation mise à jour."
    else
      @collaborateurs = Collaborateur.all
      @fonctions = Fonction.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @affectation.destroy
    redirect_to affectations_path, notice: "Affectation supprimée."
  end

  private

  def set_affectation
    @affectation = Affectation.find(params[:id])
  end

  def affectation_params
    params.require(:affectation).permit(:restaurant_id,:collaborateur_id, :fonction_id, :start_date, :end_date)
  end
end
