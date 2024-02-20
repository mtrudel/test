defmodule TestWeb.RoomChannel do
  use Phoenix.Channel

  def join(_room, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("ping", _msg, socket) do
    {:reply, {:ok, "pong"}, socket}
  end

  def terminate(_reason, _socket) do
    :ok
  end
end
