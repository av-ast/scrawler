require Logger

defmodule Scrawler.Services.Crawler.ParseLogic do
  @moduledoc """
  Implements callbacks for Crawlie parser.
  """

  @behaviour Crawlie.ParserLogic

  alias Scrawler.Utils.Uri

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
    parsed
    |> Floki.attribute("a", "href")
    |> Enum.map(&Uri.expand_url(url, &1))
    |> Enum.filter(&filter_url(url, &1))
  end

  defp filter_url(parent_url, url) do
    cond do
      Uri.same_urls(parent_url, url) ->
        false
      Uri.same_subdomain(parent_url, url) ->
        true
      true ->
        false
    end
  end

end
