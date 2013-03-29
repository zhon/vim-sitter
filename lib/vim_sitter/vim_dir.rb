require 'fileutils'

module VimSitter
  class VimDir
    # TODO need 
    # linux
    # mac

    def create_bundle
      FileUtils.mkdir_p(self.class.bundle_dir)
    end

    def create_autoload
      FileUtils.mkdir_p(self.class.base_dir + '/autoload')
    end

    def create_swap
      FileUtils.mkdir_p(data_dir + '/swap')
    end

    def create_backup
      FileUtils.mkdir_p(data_dir + '/backup')
    end

    def create_undo
      FileUtils.mkdir_p(data_dir + '/undo')
    end

    def self.cd_to_bundle repo_name=''
      FileUtils.cd "#{bundle_dir}/#{repo_name}"
    end

    def self.repo_exists? repo_name
      File.exists? "#{bundle_dir}/#{repo_name}"
    end

    def data_dir
      ENV['AppData'].gsub('\\','/') + '/Vim'
    end

    def self.base_dir
      File.expand_path("~/#{windows? ? 'vimfiles' : '.vim'}")
    end

    def self.bundle_dir
      "#{base_dir}/bundle"
    end

    def self.windows?
      RUBY_PLATFORM =~ /(win|w)32$/
    end

  end
end
