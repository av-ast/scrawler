defmodule Scrawler.CrawlTest do
  use Scrawler.ModelCase

  alias Scrawler.Crawl

  @valid_attrs %{max_depth: 42, max_retries: 42, url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Crawl.changeset(%Crawl{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Crawl.changeset(%Crawl{}, @invalid_attrs)
    refute changeset.valid?
  end
end
