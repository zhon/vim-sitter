
require "vim_sitter/vim_dir"

require_relative 'test_helper'

class VimDirTest < FlexMockTestCase

  def test_create_windows_dirs
    check :create_bundle,   /vimfiles.bundle/
    check :create_autoload, /vimfiles.autoload/
    check :create_swap,     /AppData.+Vim.swap/
    check :create_backup,   /AppData.+Vim.backup/
    check :create_undo,     /AppData.+Vim.undo/
  end

  def test_cd_to_bundle
    flexmock(FileUtils)
      .should_receive(:cd)
      .with(/bundle\/$/)
      .once
    VimDir.cd_to_bundle
  end

  def test_cd_to_bundle_repo
    flexmock(FileUtils)
      .should_receive(:cd)
      .with(/repo$/)
      .once
    VimDir.cd_to_bundle 'repo'
  end

  def test_repo_exists
    flexmock(File)
      .should_receive(:exists?)
      .with(/repo/)
      .once
      VimDir.repo_exists? 'repo'
  end

  def check(method, regex)
    dir = VimDir.new
    flexmock(FileUtils)
      .should_receive(:mkdir_p)
      .once
      .with(regex)
    dir.send method
  end

end
