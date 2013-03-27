require "minitest/unit"
require 'flexmock'

MiniTest::Unit.autorun


class FlexMockTestCase < MiniTest::Unit::TestCase
  include FlexMock::TestCase
  include VimSitter
end
