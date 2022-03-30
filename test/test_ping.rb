require 'minitest/autorun'
require 'smpl_prflr'

class TestPing < Minitest::Test
  def test_reverse_string
    ping = SmplPrflr.ping
    assert_equal("PONG", ping)
  end
end