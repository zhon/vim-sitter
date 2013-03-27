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

  def base_dir
    File.expand_path("~/#{windows? ? 'vimfiles' : '.vim'}")
  end

  def windows?
    RUBY_PLATFORM =~ /(win|w)32$/
  end

end
