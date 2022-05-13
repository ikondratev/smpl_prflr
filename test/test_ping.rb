require 'minitest/autorun'
require 'smpl_prflr'
require 'smpl_prflr/version'

class TestPing < Minitest::Test
  include SmplPrflr

  def test_reverse_string
    assert_equal("PONG", ping)
  end

  def test_version
    assert_equal("0.1.0", SmplPrflr::VERSION)
  end
end