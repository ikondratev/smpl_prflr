require 'minitest/autorun'
require 'smpl_prflr'

class TestPing < Minitest::Test
  include SmplPrflr

  def test_reverse_string
    assert_equal("PONG", ping)
  end
end