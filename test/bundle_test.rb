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
