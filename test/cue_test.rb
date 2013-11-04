require 'test_helper'

class CueTest < Minitest::Test
  def setup
    @machine = QLab.connect 'localhost', 53000
  end

  def teardown
    @machine.close
  end

  def test_a_cue_is_reachable
    workspace = @machine.workspaces.first

    refute_nil workspace.cue_lists
    refute_nil workspace.cue_lists.first
    refute_nil workspace.cue_lists.first.cues
    refute_nil workspace.cue_lists.first.cues.first
  end

  def test_a_cue_can_start
    workspace = @machine.workspaces.first
    cue = workspace.cue_lists.first.cues.first
    assert cue.start
  end
end

