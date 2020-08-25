class Api::V1::AdventuresController < ApplicationController
  before_action :set_adventure, only: [:update, :show, :destroy]


  def index
    if params[:user_id]
      user= User.find_by(id: params[:id])
      adventures= user.adventures.all
      render json: adventures
    else
      adventures= Adventures.all
      render json: adventures
    end
  end

  def create
    #only available as nested route under user
    user= User.find_by(id: params[:id])
    adventure= user.adventure.build(adventure_params)
    if adventure.save
        render json: adventure, status: :accepted
      else
        render json: {errors: adventure.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def update
    if adventure
      adventure.update(adventure)
      render json: adventure, status: :accepted
    else
      render json: {errors: adventure.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def destroy
    if adventure
      adventure.destroy
      render json: adventure, status: :accepted
    else
      render json: {errors: adventure.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def show
    if adventure
      render json: adventure, status: :accepted
    else
      render json: {errors: adventure.errors.full_messages}, status: :unprocessible_entity
    end
  end

  private

  def set_adventure
    adventure= Adventure.find_by(id: params[:id])
  end

  def adventure_params
    params.require(:adventure).permit(:title, :description, :website_url, :image_url, :likes, :complete, :user_id)
  end


end
