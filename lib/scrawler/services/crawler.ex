require Logger

defmodule Scrawler.Services.Crawler do
  alias Scrawler.Services.Crawler.ParseLogic
  alias Experimental.Flow

  @doc """
  Runs crawler
  """
  def run(crawl) do
		options = [
      max_depth: crawl.max_depth,
      max_retries: crawl.max_retries
    ]

    Logger.error("====================")
    Logger.error(inspect(crawl.url))
    Logger.error(inspect(options))
    results = Crawlie.crawl([crawl.url], ParseLogic, options)
    |> Flow.partition()
    Logger.error(inspect(results))
    Logger.error("====================")
  end

end
