require 'fileutils'

class VimDir
  # TODO need 
  # .vim dir
  # libarary vim dir
  #

  def create_bundle
    bundle_dir = "#{base_dir}/bundle"
    FileUtils.mkdir_p(bundle_dir)
  end

  def create_autoload
    bundle_dir = "#{base_dir}/autoload"
    FileUtils.mkdir_p(bundle_dir)
  end

  def create_swap
    dir = ENV['AppData'].gsub('\\','/') + '/Vim/swap'
    FileUtils.mkdir_p(dir)
  end

  def base_dir
    File.expand_path("~/#{windows? ? 'vimfiles' : '.vim'}")
  end

  def windows?
    RUBY_PLATFORM =~ /(win|w)32$/
  end

end
