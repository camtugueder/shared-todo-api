require 'rails_helper'

RSpec.describe "Groups", type: :request do
  describe "GET /groups/all_details" do
    let!(:group) { create(:group) }
    let!(:friend1) { create(:friend, group: group) }
    let!(:friend2) { create(:friend, group: group) }
    let!(:task1) { create(:task, friend: friend1) }
    let!(:task2) { create(:task, friend: friend2) }

    before do
      get all_details_groups_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns all groups with their friends and tasks" do
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(1) # Assuming you have one group

      # Test the structure of the response
      expect(json_response.first['id']).to eq(group.id)
      expect(json_response.first['friends'].length).to eq(2)
      expect(json_response.first['friends'].first['tasks'].length).to eq(1)
    end
  end
end