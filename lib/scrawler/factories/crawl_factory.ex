defmodule Scrawler.Factories.CrawlFactory do
  alias Scrawler.Crawl
  alias Scrawler.Repo
  alias Scrawler.Services.Crawler

  @doc false
  def create(params) do
    changeset = Crawl.changeset(%Crawl{}, params)

    case Repo.insert(changeset) do
      {:ok, crawl} ->
        {:ok, launched_crawl} = Crawl.launch(crawl) |> Repo.update()
        #TODO: async
          Crawler.run(launched_crawl)
          Crawl.succeed(launched_crawl) |> Repo.update!()
        {:ok, crawl}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

end
