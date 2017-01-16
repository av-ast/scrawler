require Logger

defmodule Scrawler.Services.Crawler do
  alias Scrawler.Services.Crawler.ParseLogic

  @doc """
  Runs crawler
  """
  def run(crawl) do
		options = [
      max_depth: crawl.max_depth,
      max_retries: crawl.max_retries
    ]

    Crawlie.crawl([crawl.url], ParseLogic, options)
    |> Enum.to_list
    |> Enum.into(%{})
  end

end
