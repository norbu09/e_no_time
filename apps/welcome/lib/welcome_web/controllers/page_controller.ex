defmodule WelcomeWeb.PageController do
  use WelcomeWeb, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias Welcome.Content

  def index(conn, _params) do
    render(conn, "index.html", [content: Content.get_index(), current_user: get_session(conn, :current_user), callback_url: Helpers.callback_url(conn)])
  end

  def dynamic(conn, %{"path" => path}) do
    case Content.get_page(Enum.join(path, "/")) do
      {:ok, page} ->
        conn
        |> render("dynamic.html", page: page)
     _ -> 
        conn
        |> put_status(404)
        |> render("404.html")
    end
  end

end
