require 'yaml'
require 'hashie/mash'

module BackupRepos
  class Config
    attr_reader :options

    def initialize(options = Hashie::Mash.new({}))
      @options = options
    end

    # === OPTIONS

    def debug
      options.debug || config['debug']
    end

    def backup_root
      return if backup_root_dir.blank?
      File.expand_path(backup_root_dir)
    end

    def github_access_token
      config_token = config['github']['access_token'] if config['github']
      options.github_access_token || config_token
    end

    # ===

    def method_missing(name, *_args)
      options.send(name) || config[name.to_s]
    end

    private

    def config
      @config ||= Hashie::Mash.new(file_config)
    end

    def config_file
      File.join(Dir.home, '.backup-repos')
    end

    def file_config
      return {} unless File.exist?(config_file)
      @file_config ||= (YAML.load_file(config_file) || {})
    end

    def backup_root_dir
      options.backup_root || config['backup_root']
    end
  end
end
