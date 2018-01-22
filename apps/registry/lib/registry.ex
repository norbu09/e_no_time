defmodule ENoTime.Registry do
  @moduledoc """
  This is the cenbtral registry that handles process registration in Consul
  """

  @doc """
  Registering a worker is simple:

  ## Examples

      iex> ENoTime.Registry.add("foo")
      :ok

  """
  def add(name) do
    case Consul.Agent.Service.register(%{"Name" => name}) do
	  {:ok, _response} -> :ok
	  {:error, _response} -> :error
	end
  end

  @doc """
  Looking up a worker is simple as well:

  ## Examples

      iex> ENoTime.Registry.find("foo")
	  %{"ID" => "foo", "Address" => "", "CreateIndex" => 0, "EnableTagOverride" => false, "ModifyIndex" => 0, "Port" => 0, "Service" => "foo", "Tags" => []}

  """
  def find(name) do
    case Consul.Agent.services() do
	  {:ok, response} -> 
		response.body[name]
	  {:error, _response} -> :error
	end
  end

  @doc """
  Removing a worker from the registry is also simple:

  ## Examples

      iex> ENoTime.Registry.del("foo")
      :ok

  """
  def del(name) do
    case Consul.Agent.Service.deregister(name) do
	  {:ok, _response} -> :ok
	  {:error, _response} -> :error
	end
  end

end
