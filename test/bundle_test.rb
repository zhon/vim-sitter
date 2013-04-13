require "vim_sitter/bundle"

require_relative 'test_helper'

class BundleTest < FlexMockTestCase

  def test_install_bundle
    Config.reset
    flexmock(YAML)
      .should_receive(:load_file)
      .once
      .and_return({
        author1: ['bundle'],
        author2: ['bundle1', 'bundle2']
      })
    flexmock(Gitter)
      .should_receive(:get)
      .once
      .with(:author1, 'bundle')
      .should_receive(:get)
      .once
      .with(:author2, 'bundle1')
      .should_receive(:get)
      .once
      .with(:author2, 'bundle2')
    Bundle.install
  end

  def test_remove_bundle_not_listed_in_config
    Config.reset
    flexmock(YAML)
      .should_receive(:load_file)
      .and_return({
        author1: ['bundle'],
      })
    flexmock(Dir)
      .should_receive(:entries)
      .with(/bundle/)
      .and_return(['.', '..', 'file.txt', 'bundle', 'bundle2'])
      .once
    flexmock(File)
      .should_receive(:directory?).with(/file.txt$/).and_return(false).once
      .should_receive(:directory?).and_return(true)
    flexmock(FileUtils)
      .should_receive(:rm_rf).with(/bundle\/bundle2/).with_any_args.once
      .should_receive(:rm_rf).with(%r{.}).never
      .should_receive(:rm_rf).with(%r{..}).never
      .should_receive(:rm_rf).with(/bundle$/).never
      .should_receive(:rm_rf).with(/file.txt/).never
      .should_receive(:rm_rf).with(%r{/$}).never
    Bundle.delete_unused
  end

  def test_each_loads_file_only_once
    Config.reset
    flexmock(YAML)
      .should_receive(:load_file)
      .once
      .and_return({
        key: ['v1', 'v2']
      })
    Config.each
    Config.each
  end
end
