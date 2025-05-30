class Affectation < ApplicationRecord
  belongs_to :collaborateur
  belongs_to :restaurant
  belongs_to :fonction
  # validations
  validates :start_date, presence: true
  validate  :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || end_date >= start_date
    errors.add(:end_date, "doit être après la date de début")
  end
end