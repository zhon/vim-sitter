require 'vim_sitter/vim_dir'

module VimSitter
  class Gitter

    def self.get author, repo_name
      if VimDir.repo_exists? repo_name
        puts "Pulling #{repo_name}"
        VimDir.cd_to_bundle repo_name
        system "git pull origin master"
      else
        puts "Cloning #{repo_name}"
        VimDir.cd_to_bundle
        system "git clone https://github.com/#{author}/#{repo_name}.git"
      end
    end

  end
end
