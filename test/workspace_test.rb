require 'test_helper'

class WorkspaceTest < Minitest::Test
  def setup
    @machine = QLab.connect 'localhost', 53000
  end

  def teardown
    @machine.close
  end

  def test_refresh_loads_cues
    workspace = @machine.workspaces.first

    refute_nil workspace.connection
    refute_nil workspace.name
    refute_nil workspace.id

    refute_nil workspace.cues
    assert workspace.cues.size > 0
  end

  def test_finds_cues
    workspace = @machine.workspaces.first
    cue = workspace.cues.first

    assert_equal cue, workspace.find_cue(id: cue.id)
    assert_equal cue, workspace.find_cue(number: cue.number)
    assert_equal cue, workspace.find_cue(name: cue.name)

    refute workspace.find_cue(id: 'asdf asdf asdf asdf asdf')
    refute workspace.find_cue(number: 'asdf asdf asdf asdf asdf')
    refute workspace.find_cue(name: 'asdf asdf asdf asdf asdf')
  end

  def test_new_cue
    workspace = @machine.workspaces.first
    cue_count = workspace.cues.size

    cue = workspace.new_cue 'audio'

    assert_equal workspace.find_cue(id: cue.id), cue
    assert_equal cue_count + 1, workspace.cues.size
  end
end
