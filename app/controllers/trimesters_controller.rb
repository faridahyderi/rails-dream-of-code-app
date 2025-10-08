class TrimestersController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_trimester, only: [:show, :edit, :update]
  
  def index
    @trimesters = Trimester.all
  end

  def show
    # @trimester is already set by set_trimester
  end
  
  def new
    @trimester = Trimester.new
  end

  def create
    @trimester = Trimester.new(trimester_params)
    if @trimester.save
      redirect_to trimesters_path, notice: "Trimester created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @trimester is already set by set_trimester
  end

  def update
    if params[:trimester].blank? || params[:trimester][:application_deadline].blank?
      head :bad_request
      return
    end
  
    begin
      Date.parse(params[:trimester][:application_deadline])
    rescue ArgumentError
      head :bad_request
      return
    end
  
    if @trimester.update(trimester_params)
      redirect_to trimesters_path, notice: "Trimester was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @trimester.destroy
    redirect_to trimesters_path, notice: "Trimester deleted successfully."
  end
  
  private

  def set_trimester
    @trimester = Trimester.find(params[:id])
  end

  def trimester_params
    params.require(:trimester).permit(:title, :description, :application_deadline)
  end
end


