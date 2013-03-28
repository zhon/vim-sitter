require 'fileutils'

class VimDir
  # TODO need 
  # linux
  # mac

  def create_bundle
    bundle_dir = "#{base_dir}/bundle"
    FileUtils.mkdir_p(bundle_dir)
  end

  def create_autoload
    bundle_dir = "#{base_dir}/autoload"
    FileUtils.mkdir_p(bundle_dir)
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

  def data_dir
    ENV['AppData'].gsub('\\','/') + '/Vim'
  end

  def base_dir
    File.expand_path("~/#{windows? ? 'vimfiles' : '.vim'}")
  end

  def windows?
    RUBY_PLATFORM =~ /(win|w)32$/
  end

end
