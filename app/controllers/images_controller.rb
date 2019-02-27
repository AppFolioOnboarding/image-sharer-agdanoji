class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @images = if params[:tag].present?
                Image.tagged_with([params[:tag]], any: true)
              else
                Image.all
              end
    @images = @images.reverse
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
