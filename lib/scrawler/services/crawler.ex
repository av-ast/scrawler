require Logger

defmodule Scrawler.Services.Crawler do
  alias Experimental.Flow
  alias Scrawler.Services.Crawler.ParseLogic
  alias Scrawler.Factories.LinkFactory

  @doc """
  Runs crawler
  """
  def run(crawl) do
		options = [
      max_depth: crawl.max_depth,
      max_retries: crawl.max_retries
    ]

    Crawlie.crawl([crawl.url], ParseLogic, options)
    |> Flow.each(&create_link(crawl.id, &1))
    |> Enum.to_list()
  end

  defp create_link(crawl_id, {url, title}) do
    LinkFactory.create(%{crawl_id: crawl_id, url: url, title: title})
  end

end
