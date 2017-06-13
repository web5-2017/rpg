class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  process resize_to_fit: [400, 200]

  version :small do
    process resize_to_fill: [100,100]
  end

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "/tmp/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/user/" + [version_name, "default-avatar.jpg"].compact.join('_'))
  end

  def content_type_whitelist
    /image\//
  end
end
