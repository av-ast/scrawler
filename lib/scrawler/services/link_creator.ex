require Logger

defmodule Scrawler.Services.LinkCreator do
  alias Scrawler.Link
  alias Scrawler.Repo

  def create(params) do
    changeset = Link.changeset(%Link{}, params)

    case Repo.insert(changeset) do
      {:ok, link} ->
        page_title = Scrawler.Screenshoter.make_screenshot(link)
        Link.changeset(link, %{title: page_title}) |> Repo.update
      {:error, changeset} ->
        {:error, changeset}
    end
  end

end
