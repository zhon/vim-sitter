
require "vim_sitter/config"

require_relative 'test_helper'

class ConfigTest < FlexMockTestCase

  def test_create_does_nothing_if_config_exists
    flexmock(File)
      .should_receive(:exist?)
      .with(/config.yaml/)
      .and_return(true)
      .once
    flexmock(YAML::Store)
      .should_receive(:new)
      .never
    Config.create
  end

  def test_create
    store = flexmock('store')
    store
      .should_receive(:transaction)
      .once
      .and_return { |block|
        block.call
      }
      .should_receive(:[]=)
      .with('tpope', [ 'vim-pathogen', 'vim-sensible' ])
      .once
    flexmock(YAML::Store)
      .should_receive(:new)
      .with(/config.yaml/)
      .and_return(store)
      .once
    flexmock(File)
      .should_receive(:exist?)
      .and_return(false)
    Config.create
  end

  def test_each_iterates_over_config_file
    Config.reset
    flexmock(YAML)
      .should_receive(:load_file)
      .with(/config.yaml/)
      .once
      .and_return({
        key: ['v1', 'v2']
      })
    Config.each { |k,v|
      assert_equal(:key, k)
      assert_equal('v1', v[0])
      assert_equal('v2', v[1])
    }
    Config.each
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

  def test_list_bundles
    Config.reset
    flexmock(YAML)
      .should_receive(:load_file)
      .once
      .and_return({
        key: ['v1', 'v2'],
        key2: ['v3', 'v4']
      })
    assert_equal ['v1','v2','v3','v4'], Config.bundles
  end

  def test_reload
    flexmock(YAML)
      .should_receive(:load_file)
      .twice
    Config.reload
    Config.reload
  end

end
