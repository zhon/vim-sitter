require 'vim_sitter/vim_dir'

module VimSitter
  class Gitter

    def self.get author, repo_name
      puts "Cloning #{repo_name}"
      VimDir.cd_to_bundle
      system "git clone git://github.com/#{author}/#{repo_name}.git"
    end

  end
end
