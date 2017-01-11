require Logger

defmodule Scrawler.Services.Crawler.ParseLogic do
  @behaviour Crawlie.ParserLogic

	@doc """
  Parses page
	"""
	def parse(url, body, _options) do
    Logger.info "parsing     " <> url

    try do
      {:ok, Floki.parse(body)}
    rescue
      _e in CaseClauseError -> {:error, :case_clause_error}
      _e in RuntimeError -> {:error, :runtime_error}
    end
  end

	@doc """
  Extracts titles of pages
	"""
	def extract_data(_url, body, _options) do
    res = case Regex.run(~r/<title>([^<>]*)<\/title>/ims, body, capture: :all_but_first) do
      nil -> "no title recognized"
      title -> title
    end
    Logger.info "title     " <> res
    res
  end

  def extract_links(_url, parsed, _options) do
    res = Floki.attribute(parsed, "a", "href")
    Logger.info "links     " <> res
    res
  end
end
