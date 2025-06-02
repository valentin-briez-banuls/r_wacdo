class FonctionsController < ApplicationController
  before_action :set_fonction, only: %i[show edit update destroy]

  def index
    @q = Fonction.ransack(params[:q])
    @fonctions = @q.result(distinct: true)
  end


  def show
  end

  def new
    @fonction = Fonction.new
  end

  def create
    @fonction = Fonction.new(fonction_params)
    if @fonction.save
      redirect_to fonctions_path, notice: "Fonction créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @fonction.update(fonction_params)
      redirect_to fonctions_path, notice: "Fonction mise à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fonction.destroy
    redirect_to fonctions_path, notice: "Fonction supprimée."
  end

  private

  def set_fonction
    @fonction = Fonction.find(params[:id])
  end

  def fonction_params
    params.require(:fonction).permit(:title, :description)
  end

end
