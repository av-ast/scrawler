defmodule Scrawler.Factories.LinkFactory do
  @moduledoc """
  Creates Link instance and makes a screenshot of web-page for its URL.
  """

  alias Scrawler.Link
  alias Scrawler.Repo
  alias Scrawler.Services.Screenshoter

  @doc """
  Creates Link instances and makes a screenshot for it.

  ## Parameters

    - params: Params for the new Link instance.

  """
	@spec create(Ecto.Schema.t | Ecto.Changeset.t) :: {:ok, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
  def create(params) do
    changeset = Link.changeset(%Link{}, params)

    case Repo.insert(changeset) do
      {:ok, link} ->
        Task.start(fn -> Screenshoter.make_screenshot(link) end)
        {:ok, link}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

end
