class Affectation < ApplicationRecord
  belongs_to :collaborateur
  belongs_to :restaurant
  belongs_to :fonction
  # validations
  validates :start_date, presence: true
  validates :end_date, comparison: { greater_than: :start_date }, allow_blank: true
  validates :restaurant_id, :collaborateur_id, :fonction_id, presence: true

  private

  def end_date_after_start_date
    return if end_date.blank? || end_date >= start_date
    errors.add(:end_date, "doit être après la date de début")
  end
  def self.ransackable_attributes(auth_object = nil)
    %w[start_date end_date restaurant_id collaborateur_id fonction_id]
  end
  def self.ransackable_associations(auth_object = nil)
    %w[collaborateur restaurant fonction]
  end

end