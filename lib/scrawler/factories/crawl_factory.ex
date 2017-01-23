defmodule Scrawler.Factories.CrawlFactory do
  @moduledoc """
  Creates Crawl instance and launches crawler for its URL.
  New crawl marked with state 'launched'.
  Then crawler runs asynchronously (via Task).
  After crawler finishes crawl's state changes to 'succeeded'.
  """

  alias Scrawler.Crawl
  alias Scrawler.Repo
  alias Scrawler.Services.Crawler

  @doc """
  Creates Crawl instance and launches crawler for the given params.

  ## Parameters

    - params: Params for the new Crawl instance.

  """
	@spec create(Ecto.Schema.t | Ecto.Changeset.t) :: {:ok, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
  def create(params) do
    changeset = Crawl.changeset(%Crawl{}, params)

    case Repo.insert(changeset) do
      {:ok, crawl} ->
        {:ok, launched_crawl} = Crawl.launch(crawl) |> Repo.update()
        Task.start(fn ->
          Crawler.run(launched_crawl)
          Crawl.succeed(launched_crawl) |> Repo.update!()
        end)
        {:ok, launched_crawl}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

end
