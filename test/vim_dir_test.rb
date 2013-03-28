
require "vim_sitter/vim_dir"

require_relative 'test_helper'

class VimDirTest < FlexMockTestCase

  def setup
    @mockFileUtils = flexmock(FileUtils)
  end

  def test_create_windows_bundle_dir
    dir = VimDir.new
    @mockFileUtils.should_receive(:mkdir_p)
      .once
      .with(/vimfiles.bundle/)
    dir.create_bundle
  end

  def test_create_windows_autoload_dir
    dir = VimDir.new
    @mockFileUtils.should_receive(:mkdir_p)
      .once
      .with(/vimfiles.autoload/)
    dir.create_autoload
  end

  def test_create_windows_swap_dir
    dir = VimDir.new
    @mockFileUtils.should_receive(:mkdir_p)
      .once
      .with(/AppData.+Vim.swap/)
    dir.create_swap
  end

  def test_create_windows_backup_dir
    dir = VimDir.new
    @mockFileUtils.should_receive(:mkdir_p)
      .once
      .with(/AppData.+Vim.backup/)
    dir.create_backup
  end

  def test_create_windows_undo_dir
    dir = VimDir.new
    @mockFileUtils.should_receive(:mkdir_p)
      .once
      .with(/AppData.+Vim.undo/)
    dir.create_undo
  end

end
