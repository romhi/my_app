class Volunteer < ActiveRecord::Base

  belongs_to :congregation
  belongs_to :responsibility
  has_one :vacancy
  scope :by_congregation_id, -> congregation_id { where("congregation_id = ?", congregation_id) }
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

end
