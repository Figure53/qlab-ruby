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

  def test_a_cue_has_a_name
    workspace = @machine.workspaces.first
    cue = workspace.cue_lists.first.cues.first
    assert cue.name
  end

  def test_changes_are_picked_up_immediately
    original_name = "Name 1"
    new_name = "Name 2"

    workspace = @machine.workspaces.first
    cue = workspace.cue_lists.first.cues.first

    cue.name = original_name
    assert_equal original_name, cue.name

    cue.name = new_name
    assert_equal new_name, cue.name
  end
end

