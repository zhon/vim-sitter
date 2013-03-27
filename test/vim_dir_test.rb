
require "vim_sitter/vim_dir"

require_relative 'test_helper'

class VimDirTest < FlexMockTestCase

  def test_create_windows_bundle_dir
    dir = VimDir.new
    mock = flexmock(FileUtils)
    mock.should_receive(:mkdir_p)
      .once
      .with( /vimfiles.bundle/)
    dir.create_bundle
  end

end
