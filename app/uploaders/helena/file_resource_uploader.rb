module Helena
  class FileResourceUploader < CarrierWave::Uploader::Base
    storage Helena.config.file_storage

    after :remove, :delete_empty_upstream_dirs

    def store_dir
      "#{base_store_dir}/#{model.id}"
    end

    def base_store_dir
      "uploads/#{model.class.to_s.underscore}"
    end

    def delete_empty_upstream_dirs
      path = ::File.expand_path(store_dir, root)
      Dir.delete(path) # fails if path not empty dir

      path = ::File.expand_path(base_store_dir, root)
      Dir.delete(path) # fails if path not empty dir
    rescue SystemCallError
      true # nothing, the dir is not empty
    end
  end
end
