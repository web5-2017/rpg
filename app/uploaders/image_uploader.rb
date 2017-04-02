class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  version :presentation do
    process :resize_to_fit => [200, 200]
  end

  version :mobile_presentation do
    process resize_to_fill: [100,100]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  def cache_dir
    "/tmp/#{model.class.to_s.underscore}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/picture/" + [version_name, "adicionar-botao.jpg"].compact.join('_'))
  end

  def content_type_whitelist
    /image\//
  end
end
