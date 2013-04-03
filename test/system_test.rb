require 'vim_sitter/system'

require_relative 'test_helper'

class SystemTest < FlexMockTestCase

  def test_app_is_installed
    flexmock(System)
      .should_receive(:`)
      .once
      .with(/some_app/)
    assert System.app_installed? 'some_app'
  end

  def test_app_is_not_installed
    flexmock(System)
      .should_receive(:`)
      .once
      .and_raise(Errno::ENOENT)
    refute System.app_installed? 'some_app'
  end

  def test_git_is_installed
    flexmock(System).should_receive(:app_installed?).once
      .with(/git/)
    System.git_installed?
  end

  def test_vim_is_installed
    flexmock(System).should_receive(:app_installed?).once
      .with(/vim/)
    System.vim_installed?
  end

end
