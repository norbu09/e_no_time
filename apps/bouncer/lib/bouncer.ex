defmodule Bouncer do
  @moduledoc """
  This is the central registry that handles process registration in Consul
  """

  @doc """
  Registering a worker is simple:

  ## Examples

      iex> Bouncer.add("foo")
      {:ok, %{"status" => "success"}}

  """
  def add(name) do
    Exconsul.add_service(%{"Name" => name})
  end

  @doc """
  Looking up a worker is simple as well:

  ## Examples

      iex> Bouncer.find("foo") |> List.first |> Map.get(ServiceName)
      "foo"

  """
  def find(name) do
    case Exconsul.find_service(%{"Name" => name}) do
	  {:ok, response} -> 
		response
	  {:error, _response} -> :error
	end
  end

  @doc """
  Removing a worker from the registry is also simple:

  ## Examples

      iex> Bouncer.del("foo")
      {:ok, %{"status" => "success"}}

  """
  def del(name) do
    Exconsul.del_service(%{"ID" => name})
  end
end
