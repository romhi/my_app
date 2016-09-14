class Vacancy < ActiveRecord::Base

  belongs_to :volunteer
  validates_presence_of :name, :starts_at, :ends_at
  scope :by_location, -> (location_number){ where("name ilike ?", "%пост №#{location_number}%" ) }
  scope :by_number, -> (number){ where("number = ?", number ).first }
  scope :without_volunteer, -> { where("volunteer_id is null").order(:number) }


end
