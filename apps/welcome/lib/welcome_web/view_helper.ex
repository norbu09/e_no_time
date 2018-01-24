defmodule WelcomeWeb.ViewHelper do
  use Phoenix.HTML
  
  def markdown(txt) do
    txt
    |> Earmark.as_html!
    |> raw
  end

end
