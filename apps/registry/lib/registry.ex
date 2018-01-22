defmodule ENoTime.Registry do
  @moduledoc """
  This is the cenbtral registry that handles process registration in Consul
  """

  @doc """
  iRegistering a worker is simple:

  ## Examples

      iex> ENoTime.Registry.add(name)
      :ok

  """
  def add(name) do
    case Consul.Agent.Service.register(%{"Name" => name}) do
	  {:ok, _response} -> :ok
	  {:error, _response} -> :error
	end
  end
end
