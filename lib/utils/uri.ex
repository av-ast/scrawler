defmodule Scrawler.Utils.Uri do
  @moduledoc """
  Contains utils for working with URLs.
  """

  @doc """
    Checks if both URLs are the same (maybe except for anchor)
  """
  @spec same_urls(String.t, String.t) :: boolean()
  def same_urls(url1, url2) do
    %URI{host: host1, path: path1, query: query1} = URI.parse(url1)
    %URI{host: host2, path: path2, query: query2} = URI.parse(url2)

    {host1, path1, query1} == {host2, path2, query2}
  end

  @doc """
    Checks if both URLs have the same subdomain
  """
  @spec same_subdomain(String.t, String.t) :: boolean()
  def same_subdomain(url1, url2) do
    %URI{host: host1} = URI.parse(url1)
    %URI{host: host2} = URI.parse(url2)

    (is_nil(host1) || is_nil(host2)) ||
      String.ends_with?(host1, host2) ||
      String.ends_with?(host2, host1)
  end

  @doc """
    Expand URL
  """
  @spec expand_url(String.t, String.t) :: String.t
  def expand_url(canonical_url, url) do
    %URI{scheme: scheme, host: host} = URI.parse(canonical_url)

    cond do
      String.starts_with?(url, "//") ->
        "#{scheme}:#{url}"
      String.starts_with?(url, "/") ->
        "#{scheme}://#{host}#{url}"
      String.starts_with?(url, "#") ->
        canonical_url <> url
      true ->
        url
    end
  end

end
