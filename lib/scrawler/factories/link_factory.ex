defmodule Scrawler.Factories.LinkFactory do
  alias Scrawler.Link
  alias Scrawler.Repo
  alias Scrawler.Services.Screenshoter

  def create(params) do
    changeset = Link.changeset(%Link{}, params)

    case Repo.insert(changeset) do
      {:ok, link} ->
        Screenshoter.make_screenshot(link)
        {:ok, link}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

end
