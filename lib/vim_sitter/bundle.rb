
require 'vim_sitter/config'
require 'vim_sitter/gitter'
require 'vim_sitter/vim_dir'

module VimSitter
  class Bundle

    def self.install
      Config.each do |key, value|
        value.each do |item|
          Gitter.get key, item
        end
      end
    end

    def self.delete_unused
      bundles = Dir.entries(VimDir.bundle_dir).select { |item|
        File.directory?("#{VimDir.bundle_dir}/#{item}") && (item !~ /\.$/)
      }
      (bundles - Config.bundles).each do |item|
        FileUtils.rm_rf "#{VimDir.bundle_dir}/#{item}", :verbose => true
      end
    end

  end
end
