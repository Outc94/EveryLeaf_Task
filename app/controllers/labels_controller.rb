class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]
  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    @label.user_id = current_user.id

    if @label.save
      redirect_to labels_path, notice: 'Label was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: 'Label was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
   @label.destroy
   redirect_to labels_url, notice: 'Label was successfully deleted.'
  end

  private
    def set_label
      @label = Label.find(params[:id])
    end

    def label_params
      params.require(:label).permit(:name, :user_id)
    end
end
