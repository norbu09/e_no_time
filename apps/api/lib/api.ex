defmodule Api.API do
  @moduledoc """
  Documentation for Api.
  """
  use Maru.Router

  before do
    plug Plug.Logger
  end

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]

  mount Api.Router.Foo

  rescue_from :all do
    conn
    |> put_status(500)
    |> text("Server Error")
  end

end
