class Volunteer < ActiveRecord::Base

  belongs_to :congregation
  belongs_to :responsibility
  has_one :vacancy
  scope :by_congregation_id, -> congregation_id { where("congregation_id = ?", congregation_id) }
  # scope :without_vacancy, -> (vacancy_id){ Vacancy.find(vacancy_id).try(:volunteer).present? ? (where("id not in (?)", Vacancy.where("volunteer_id is not null").pluck(:volunteer_id)).order(:congregation_id)) : order(:congregation_id)}

  validates :age, numericality: { greater_than: 18}
  validates_presence_of :congregation_id, :last_name, :first_name, :age,
                        :convenient_start_time, :convenient_end_time, :will_be_since_8, :car,
                        :will_be_until_17, :outdoor, :phone, :responsibility_id

  def full_info
    "#{congregation.city.region.name[0]}.обл. #{city_and_congregation} #{last_name.strip} #{first_name[0]}. #{responsibility.name} #{age}л."
  end

  def city_and_congregation
    congregation.city.name == congregation.name ? "#{congregation.name}" : "#{congregation.city.name} #{congregation.name}"
  end

  def self.without_vacancy(vacancy_id)
    if Vacancy.where("volunteer_id is not null").pluck(:volunteer_id).count > 0
      self.where("id not in (?)", Vacancy.where("volunteer_id is not null").pluck(:volunteer_id))
    else
      self.order(:congregation_id)
    end
  end

end
