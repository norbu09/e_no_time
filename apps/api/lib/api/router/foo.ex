defmodule Api.Router.Foo do
  use Maru.Router

  # curl http://localhost:4001/foo/bar/foobar
  # {"foobar":{"bar":"foo"}}
  resource "/foo" do
    get do
      json(conn, %{ coins: ["USD", "BTC"] })
    end
    namespace :bar do
      route_param :baz, type: String do
        desc "Returns the details of baz"
        get do
          doc = %{params[:baz] => %{"bar" => "foo"}}
          json(conn, doc)
        end
      end
    end
  end
end
