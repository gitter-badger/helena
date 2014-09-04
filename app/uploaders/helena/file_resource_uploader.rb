module Helena
  class FileResourceUploader < CarrierWave::Uploader::Base
    storage Helena.config.file_storage

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
end
