defmodule Test.Dumper do
  use Task

  def start_link(_) do
    Task.start_link(__MODULE__, :run, [])
  end

  def run() do
    {:ok, pid} = Bandit.PhoenixAdapter.bandit_pid(TestWeb.Endpoint, :https)
    do_run(pid)
  end

  def do_run(pid) do
    {:ok, pids} = ThousandIsland.connection_pids(pid)
    IO.puts("#{length(pids)} bandit connections")
    IO.puts("#{count_for_socket(TestWeb.Endpoint.TestWeb.UserSocket)} user sockets")
    IO.puts("#{count_for_socket(TestWeb.Endpoint.Phoenix.LiveReloader.Socket)} reload sockets")
    IO.puts("#{count_for_socket(TestWeb.Endpoint.Phoenix.LiveView.Socket)} LV sockets")
    IO.puts("#{:erlang.statistics(:run_queue)} run queue")
    Process.sleep(1000)
    do_run(pid)
  end

  defp count_for_socket(socket) do
    Supervisor.which_children(socket)
    |> Enum.reduce(0, fn {_, pid, _, _}, acc ->
      acc + Supervisor.count_children(pid)[:active]
    end)
  end
end
