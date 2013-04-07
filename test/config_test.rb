
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

end
