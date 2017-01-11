defmodule Scrawler.Factories.CrawlFactory do
  alias Scrawler.Crawl
  alias Scrawler.Repo
  alias Scrawler.Services.Crawler

  @doc false
  def create(params) do
    changeset = Crawl.changeset(%Crawl{}, params)

    case Repo.insert(changeset) do
      {:ok, crawl} ->
        Crawler.run(crawl)
        {:ok, crawl}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

end
