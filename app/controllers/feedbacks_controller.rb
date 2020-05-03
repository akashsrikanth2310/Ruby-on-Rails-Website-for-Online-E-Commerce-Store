class FeedbacksController < ApplicationController
   before_action :set_feedback, only: [:show]
  skip_before_action  :authenticate_user!, only: [:new,:create,:show]
  before_action :is_admin?, only: [:index]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback, notice: 'Feedback was successfully created.' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end





private

# Use callbacks to share common setup or constraints between actions.
def set_feedback
  @feedback = Feedback.find(params[:id])
end

# Only allow a list of trusted parameters through.
def feedback_params
  params.require(:feedback).permit(:name, :email, :comments)
end

end