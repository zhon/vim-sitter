
require "vim_sitter/gitter"

require_relative 'test_helper'

class GitterTest < FlexMockTestCase

  def test_clone_repo
    author = 'jim'
    repo_name = 'silly_code'
    flexmock(Gitter)
      .should_receive(:puts)
      .with("Cloning #{repo_name}")
      .once
    flexmock(VimDir)
      .should_receive(:cd_to_bundle)
      .once
    flexmock(Gitter)
      .should_receive(:system)
      .with(/git clone .*#{author}.*#{repo_name}/)
      .once

    Gitter.get author, repo_name
  end

end


