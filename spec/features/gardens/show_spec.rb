require 'rails_helper'

RSpec.describe 'garden show page' do

  it 'displays unique list of plants that take less than 100 days to harvest' do
    plant1 = Plant.create!(name: "Swiss Chard", description: "Bitter and nice", days_to_harvest: 80)
    plant2 = Plant.create!(name: "Tomato", description: "One giant tomato", days_to_harvest: 120)
    plant3 = Plant.create!(name: "Squash", description: "Like a cucumber but scary", days_to_harvest: 100)
    plant4 = Plant.create!(name: "Arugula", description: "Spicy", days_to_harvest: 50)

    garden1 = Garden.create!(name: "Stanton", organic: true)
      plot1_garden1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden1.id)
        plotplant1 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant1.id)
        plotplant2 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant2.id)
        plotplant5 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant2.id)
      plot2_garden1 = Plot.create!(number: 12, size: "Small", direction: "South", garden_id: garden1.id)
        plotplant3 = PlotPlant.create!(plot_id: plot2_garden1.id, plant_id: plant3.id)
        plotplant4 = PlotPlant.create!(plot_id: plot2_garden1.id, plant_id: plant4.id)
        plotplant6 = PlotPlant.create!(plot_id: plot2_garden1.id, plant_id: plant4.id) 
        # checking for distinctness

    visit garden_path(garden1.id)

    within "#under-100-day-plants" do
      expect(page).to have_content("Swiss Chard")
      expect(page).to have_content("Arugula")
    end

  end

end

# User Story 3, Garden's Plants
# As a visitor
# When I visit an garden's show page
# Then I see a list of plants that are included in that garden's plots
# And I see that this list is unique (no duplicate plants)
# And I see that this list only includes plants that take less than 100 days to harvest