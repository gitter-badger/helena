module Helena
  class FileResource
    include Helena::Concerns::ApplicationModel

    mount_uploader :file, Helena::FileResourceUploader

    embedded_in :file_resource, polymorphic: true
  end
end
