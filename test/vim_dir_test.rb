
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

  def check(method, regex)
    dir = VimDir.new
    flexmock(FileUtils)
      .should_receive(:mkdir_p)
      .once
      .with(regex)
    dir.send method
  end

end
