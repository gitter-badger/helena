module Helena
  class InitializerGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      template 'helena.rb', File.join('config/initializers', class_path, file_name)
    end
  end
end
