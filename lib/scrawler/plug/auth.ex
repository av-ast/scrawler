defmodule Scrawler.Plug.Auth do
  @behaviour Plug
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  @doc false
  def init(opts), do: opts

  @doc """
  Redirects unsigned users to sign-in form.
  """
  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be signed in to access this page.")
      |> redirect(to: Scrawler.Router.Helpers.session_path(conn, :new))
      |> halt()
    end
  end

end
