require Logger

defmodule Scrawler.Services.Crawler.ParseLogic do
  @behaviour Crawlie.ParserLogic

	@doc """
  Parses page
	"""
	def parse(_url, body, _options) do
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
  def extract_data(url, parsed, _options) do
    title = parsed |> Floki.find("title") |> Floki.text()
    ["#{url}": title]
  end

  def extract_links(url, parsed, _options) do
    Floki.attribute(parsed, "a", "href") |> Enum.map(&prepare_url(url, &1))
  end

  defp prepare_url(parent_url, url) do
    %URI{scheme: scheme, host: host} = URI.parse(parent_url)

    cond do
      String.starts_with?(url, "//") ->
        "#{scheme}:#{url}"
      String.starts_with?(url, "/") ->
        "#{scheme}://#{host}#{url}"
      String.starts_with?(url, "#") ->
        parent_url <> url
      true ->
        url
    end
  end

end