module Helena
  class Engine < ::Rails::Engine
    isolate_namespace Helena
    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  end

  def self.setup(&block)
    # rubocop:disable Style/ClassVars
    @@config ||= Helena::Engine::Configuration.new

    yield @@config if block
    # rubocop:enable Style/ClassVars
  end

  def self.config
    Rails.application.config
  end
end
