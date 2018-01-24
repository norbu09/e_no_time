defmodule WelcomeWeb.PageController do
  use WelcomeWeb, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias Welcome.Content

  def index(conn, _params) do
    render(conn, "index.html", [content: Content.get_index(), current_user: get_session(conn, :current_user), callback_url: Helpers.callback_url(conn)])
  end

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case validate_password(auth.credentials) do
      :ok ->
        user = %{id: auth.uid, name: name_from_auth(auth), avatar: auth.info.image}
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> redirect(to: "/")
      { :error, reason } ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  defp validate_password(creds) do
    IO.puts("Creds: #{inspect creds}")
  end

  defp name_from_auth(auth) do
    IO.puts("Auth: #{inspect auth}")
  end
end
