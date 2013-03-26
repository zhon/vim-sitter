require "vim_sitter/installation_check"

require_relative 'test_helper'

class InstallationCheckTest < FlexMockTestCase

  def test_app_is_installed
    flexmock(InstallationCheck)
      .should_receive(:`)
      .once
      .with(/some_app/)
    assert InstallationCheck.app_installed? 'some_app'
  end

  def test_app_is_not_installed
    flexmock(InstallationCheck)
      .should_receive(:`)
      .once
      .and_raise(Errno::ENOENT)
    refute InstallationCheck.app_installed? 'some_app'
  end

  def test_git_is_installed
    flexmock(InstallationCheck).should_receive(:app_installed?).once
      .with(/git/)
    InstallationCheck.git_installed?
  end

  def test_vim_is_installed
    flexmock(InstallationCheck).should_receive(:app_installed?).once
      .with(/vim/)
    InstallationCheck.vim_installed?
  end

end
