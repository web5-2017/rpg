class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
    @picture = Picture.new
  end

  def create
    @picture = Picture.new params.require(:picture).permit(:image)

    if @picture.save
      flash[:success] = "imagem salva no servidor"
      redirect_to action: :index
    else
      flash[:error] = "houve um problema ao salvar a imagem"
      redirect_to action: :index
    end
  end
end
