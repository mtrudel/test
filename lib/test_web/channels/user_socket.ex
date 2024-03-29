defmodule TestWeb.UserSocket do
  use Phoenix.Socket

  channel "room:*", TestWeb.RoomChannel

  def connect(params, socket, _connect_info) do
    # {TestWeb.UserSocket, :_, :_}
    # |> :recon_trace.calls({1000, 1})

    {:ok, assign(socket, :user_id, params["user_id"])}
  end

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
