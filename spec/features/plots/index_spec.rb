require 'rails_helper'

RSpec.describe 'plot index page' do

  it 'displays a list of all plot numbers' do
    garden1 = Garden.create!(name: "Stanton", organic: true)
      plot1_garden1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden1.id)
      plot2_garden1 = Plot.create!(number: 12, size: "Small", direction: "South", garden_id: garden1.id)

    garden2 = Garden.create!(name: "Barnard", organic: false)
      plot1_garden2 = Plot.create!(number: 5, size: "Medium", direction: "North", garden_id: garden2.id)

    visit plots_path

    within "#plot-#{plot1_garden1.id}" do
      expect(page).to have_content("Plot Number: 25")
    end

    within "#plot-#{plot2_garden1.id}" do
      expect(page).to have_content("Plot Number: 12")
    end

    within "#plot-#{plot1_garden2.id}" do
      expect(page).to have_content("Plot Number: 5")
    end
  end

  it 'under each plot number, displays the names of all of that plot\'s plants' do

    plant1 = Plant.create!(name: "Swiss Chard", description: "Bitter and nice", days_to_harvest: 80)
    plant2 = Plant.create!(name: "Tomato", description: "One giant tomato", days_to_harvest: 120)
    plant3 = Plant.create!(name: "Squash", description: "Like a cucumber but scary", days_to_harvest: 100)

    garden1 = Garden.create!(name: "Stanton", organic: true)
      plot1_garden1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden1.id)
        plotplant1 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant1.id)
        plotplant2 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant2.id)
      plot2_garden1 = Plot.create!(number: 12, size: "Small", direction: "South", garden_id: garden1.id)
        plotplant3 = PlotPlant.create!(plot_id: plot2_garden1.id, plant_id: plant3.id)

    garden2 = Garden.create!(name: "Barnard", organic: false)
      plot1_garden2 = Plot.create!(number: 5, size: "Medium", direction: "North", garden_id: garden2.id)
        plotplant4 = PlotPlant.create!(plot_id: plot1_garden2.id, plant_id: plant1.id)

    visit plots_path

    within "#plot-#{plot1_garden1.id}" do
      expect(page).to have_content("Plot Number: 25")

      expect(page).to have_content("Swiss Chard")
      expect(page).to have_content("Tomato")
      expect(page).to_not have_content("Squash")
    end

    within "#plot-#{plot2_garden1.id}" do
      expect(page).to have_content("Plot Number: 12")

      expect(page).to_not have_content("Swiss Chard")
      expect(page).to_not have_content("Tomato")
      expect(page).to have_content("Squash")
    end

    within "#plot-#{plot1_garden2.id}" do
      expect(page).to have_content("Plot Number: 5")

      expect(page).to have_content("Swiss Chard")
      expect(page).to_not have_content("Tomato")
      expect(page).to_not have_content("Squash")
    end
  end

  it 'when user clicks on "remove this plant" link, they are returned to the plot index page and no longer see the plant listed under that plot' do
    plant1 = Plant.create!(name: "Swiss Chard", description: "Bitter and nice", days_to_harvest: 80)
    plant2 = Plant.create!(name: "Tomato", description: "One giant tomato", days_to_harvest: 120)
    plant3 = Plant.create!(name: "Squash", description: "Like a cucumber but scary", days_to_harvest: 100)

    garden1 = Garden.create!(name: "Stanton", organic: true)
      plot1_garden1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden1.id)
        plotplant1 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant1.id)
        plotplant2 = PlotPlant.create!(plot_id: plot1_garden1.id, plant_id: plant2.id)
      plot2_garden1 = Plot.create!(number: 12, size: "Small", direction: "South", garden_id: garden1.id)
        plotplant3 = PlotPlant.create!(plot_id: plot2_garden1.id, plant_id: plant3.id)

    visit plots_path

    within "#plot-#{plot1_garden1.id}-plant-#{plant1.id}" do
      expect(page).to have_content("Swiss Chard")
      click_on "Remove This Plant"
    end

    expect(current_path).to eq(plots_path)

    within "#plot-#{plot1_garden1.id}" do
      expect(page).to_not have_content("Swiss Chard")
    end
  
  end

end