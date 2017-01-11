defmodule Scrawler.Factories.LinkFactory do
  alias Scrawler.Link
  alias Scrawler.Repo
  alias Scrawler.Services.Screenshoter

  def create(params) do
    changeset = Link.changeset(%Link{}, params)

    case Repo.insert(changeset) do
      {:ok, link} ->
        page_title = Screenshoter.make_screenshot(link)
        Link.changeset(link, %{title: page_title}) |> Repo.update
      {:error, changeset} ->
        {:error, changeset}
    end
  end

end
