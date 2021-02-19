require 'rails_helper'

RSpec.describe 'Applications new page' do
  # story 3 new page form
  # happy path
  it 'contains a form for filling out a new applicaton' do
    visit '/applications/new'
    fill_in 'application[name]', with: "Dominic"
    fill_in 'application[street]', with: "2298 West 28th Ave"
    fill_in 'application[city]', with: "Denver"
    fill_in 'application[state]', with: "Colorado"
    fill_in 'application[zip_code]', with: 80211

    click_on 'Submit'
    expect(page).to have_content("Dominic")
    expect(page).to have_content("2298 West 28th Ave, Denver, Colorado")
    expect(page).to have_content(80211)
    expect(page).to have_content("In Progress")
  end

  # sad path test story 4
  describe "returns the applications new form if you don't fill out all fields" do
    it "and I see a message that tells me what I did wrong" do
      visit '/applications/new'
      click_on 'Submit'
      expect(page).to have_content("Application not Accepted: Missing Required Information")
      expect(current_path).to eq('/applications/new')
    end
  end
end
