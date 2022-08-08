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

  xit 'sorts the plant list by the number of plots a plant appears in' do
    plant1 = Plant.create!(name: "Swiss Chard", description: "Bitter and nice", days_to_harvest: 80)
    plant2 = Plant.create!(name: "Tomato", description: "One giant tomato", days_to_harvest: 70)
    plant3 = Plant.create!(name: "Squash", description: "Like a cucumber but scary", days_to_harvest: 60)
    plant4 = Plant.create!(name: "Arugula", description: "Spicy", days_to_harvest: 50)

    garden1 = Garden.create!(name: "Stanton", organic: true)
      plot1_garden1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden1.id)
        chard1 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant1.id)
        tomato1 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant2.id)
        squash1 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant3.id)
        arugula1 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant4.id)
      plot2_garden1 = Plot.create!(number: 25, size: "Medium", direction: "South", garden_id: garden1.id)
        chard2 = PlotPlant.create!(plot_id: plot2_garden1.id, plant_id: plant1.id)
        tomato2 = PlotPlant.create!(plot_id: plot2_garden1.id, plant_id: plant2.id)
        squash2 = PlotPlant.create!(plot_id: plot2_garden1.id, plant_id: plant3.id)
      plot3_garden1 = Plot.create!(number: 25, size: "Small", direction: "West", garden_id: garden1.id)
        chard3 = PlotPlant.create!(plot_id: plot3_garden1.id, plant_id: plant1.id)
        tomato3 = PlotPlant.create!(plot_id: plot3_garden1.id, plant_id: plant2.id)
      plot4_garden1 = Plot.create!(number: 25, size: "Very Small", direction: "North", garden_id: garden1.id)
        tomato4 = PlotPlant.create!(plot_id: plot4_garden1.id, plant_id: plant2.id)

    # four tomato -> three chard -> two squash -> one arugula

    visit garden_path(garden1.id)

    within "#plant-1" do
      expect(page).to have_content("Tomato")
    end
    within "#plant-2" do
      expect(page).to have_content("Swiss Chard")
    end
    within "#plant-3" do
      expect(page).to have_content("Squash")
    end
    within "#plant-4" do
      expect(page).to have_content("Arugula")
    end


  end

end

# Extension,
# As a visitor
# When I visit a garden's show page,
# Then I see the list of plants is sorted by the number of plants that appear in any of that garden's plots from most to least
# (Note: you should only make 1 database query to retrieve the sorted list of plants)