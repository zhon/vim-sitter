
module VimSitter
  class InstallationCheck

    def self.git_installed?
      app_installed? 'git'
    end

    def self.vim_installed?
      app_installed? 'vim'
    end

    def self.app_installed? app
      begin
        `#{app} --version`
      rescue
        return false
      end
      return true
    end

  end
end
