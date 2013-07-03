require 'fileutils'

module VimSitter
  class VimDir
    # TODO need 
    # linux

    def self.create_bundle
      FileUtils.mkdir_p(bundle_dir)
    end

    def self.create_autoload
      FileUtils.mkdir_p autoload_dir
    end

    def self.create_swap
      FileUtils.mkdir_p(data_dir + '/swap')
    end

    def self.create_backup
      FileUtils.mkdir_p(data_dir + '/backup')
    end

    def self.create_undo
      FileUtils.mkdir_p(data_dir + '/undo')
    end

    def self.cd_to_bundle repo_name=''
      FileUtils.cd "#{bundle_dir}/#{repo_name}"
    end

    def self.repo_exists? repo_name
      File.exists? "#{bundle_dir}/#{repo_name}"
    end

    def self.cp_to_autoload path
      FileUtils.cp "#{bundle_dir}/#{path}", autoload_dir
    end

    def self.add_to_vimrc s
      new_lines = s.split("\n").map {|item| item + "\n"}
      lines = IO.readlines(vimrc_path)
      unless lines & new_lines == new_lines
        require 'tempfile'
        begin
          tmp = Tempfile.new('vimrc')
          tmp.binmode
          tmp.print new_lines.join
          tmp.print lines.join
          tmp.close
          FileUtils.copy_file(tmp.path, vimrc_path)
        ensure
          tmp.close
          tmp.unlink
        end
      end
    end

    def self.data_dir
      if windows?
        ENV['AppData'].gsub('\\','/') + '/Vim'
      elsif mac?
        File.expand_path "~/Library/Vim"
      elsif linux?
        File.expand_path "~/.vim"
      else
        raise "os '#{RUBY_PLATFORM}' not recognized!"
      end
    end

    def self.base_dir
      File.expand_path("~/#{windows? ? 'vimfiles' : '.vim'}")
    end

    def self.bundle_dir
      "#{base_dir}/bundle"
    end

    def self.autoload_dir
      "#{base_dir}/autoload"
    end

    def self.vimrc_path
      File.expand_path("~/#{windows? ? '_vimrc' : '.vimrc'}")
    end

    def self.windows?
      RUBY_PLATFORM =~ /(win|w)32$/
    end

    def self.mac?
      RUBY_PLATFORM =~ /darwin/
    end

    def self.linux?
      RUBY_PLATFORM =~ /linux/
    end

  end
end
