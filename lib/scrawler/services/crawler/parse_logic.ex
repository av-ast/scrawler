require Logger

defmodule Scrawler.Services.Crawler.ParseLogic do
  @moduledoc """
  Implements callbacks for Crawlie parser.
  """

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
  Extracts title of page
  """
  def extract_data(url, parsed, _options) do
    title = parsed |> Floki.find("title") |> Floki.text()
    [{url, title}]
  end

  @doc """
  Extracts links from page source
  """
  def extract_links(url, parsed, _options) do
    #TODO: skip urls from another domain
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
