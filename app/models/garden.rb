class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants

  def under_100_day_plants
    self.plants
        .select("plants.*")
        .where("plants.days_to_harvest < ?", 100)
        .distinct
  end
end
