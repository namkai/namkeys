defmodule Github do
  @moduledoc """
  Documentation for Github.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Github.hello()
      :world

  """
  # qixxit_frontend
  # |> get_repos
  # |> find_specific_repo
  # |> download_repo
  # |> modify_file
  # |> commit

  def get_user(user) do
    case HTTPoison.get("https://api.github.com/users/" <> user) do
      {:ok, response} -> response.body |> Poison.decode() |> IO.inspect()
      {:error, error} -> error |> IO.inspect()
    end
  end

  def get_user_repos(user) do
    user
    |> call_client
    |> log_response
  end

  def log_response(response) do
    case response do
      {:ok, response} -> response |> length |> IO.inspect()
      {:error, %{"message" => message}} -> IO.inspect(message)
      {:error, error} -> error |> IO.inspect()
    end
  end

  def call_client(user) do
    case HTTPoison.get("https://api.github.com/users/" <> user <> "/repos") do
      {:ok, %{body: body, status_code: 200}} -> body |> Poison.decode()
      {:ok, %{body: body}} -> {:error, body |> Poison.decode()}
      error -> error
    end
  end
end
