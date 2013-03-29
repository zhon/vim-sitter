
require "vim_sitter/gitter"

require_relative 'test_helper'

class GitterTest < FlexMockTestCase

  def test_clone_repo
    author = 'jim'
    repo_name = 'silly_code'
    flexmock(VimDir)
      .should_receive(:repo_exists?)
      .and_return(false)
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

  def test_pull_repo
    author = 'jim'
    repo_name = 'silly_code'
    flexmock(VimDir)
      .should_receive(:repo_exists?)
      .with(repo_name)
      .and_return(true)
      .once
    flexmock(Gitter)
      .should_receive(:puts)
      .with("Pulling #{repo_name}")
      .once
    flexmock(VimDir)
      .should_receive(:cd_to_bundle)
      .with(repo_name)
      .once
    flexmock(Gitter)
      .should_receive(:system)
      .with('git pull origin master')
      .once

    Gitter.get author, repo_name

  end

end


