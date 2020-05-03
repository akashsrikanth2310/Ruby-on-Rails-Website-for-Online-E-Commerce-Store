require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  context "when the user is an admin" do

    before(:each) do
      @current_user = User.first
    end
  describe "GET #index" do
    it "should lists all the feedbacks" do
      feedback = Feedback.all
      get :index
      expect(assigns(:feedbacks)).to eq(feedback)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  end
end
