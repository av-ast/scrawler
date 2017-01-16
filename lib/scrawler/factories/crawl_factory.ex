defmodule Scrawler.Factories.CrawlFactory do
  alias Scrawler.Crawl
  alias Scrawler.Repo
  alias Scrawler.Services.Crawler

  @doc false
  def create(params) do
    changeset = Crawl.changeset(%Crawl{}, params)

    case Repo.insert(changeset) do
      {:ok, crawl} ->
        crawl |> Crawl.launch() |> Repo.update!()
        for {k, v} <- Crawler.run(crawl) do

        end
        {:ok, crawl}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

end
