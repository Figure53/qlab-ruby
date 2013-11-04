require 'test_helper'

class MachineTest < Minitest::Test
  def test_can_connect
    machine = QLab.connect 'localhost', 53000
    assert machine.connected?
  end

  def test_can_load_workspaces
    machine = QLab.connect 'localhost', 53000
    assert machine.workspaces.size > 0
  end

  def test_can_find_workspaces
    machine = QLab.connect 'localhost', 53000
    assert machine.workspaces.size > 0

    ws = machine.workspaces.first

    assert_equal ws, machine.find_workspace(id: ws.id)
    assert_equal ws, machine.find_workspace(name: ws.name)

    refute machine.find_workspace(id: 'nonsense')
    refute machine.find_workspace(name: 'nonsense')
  end
end
