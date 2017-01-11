defmodule Scrawler.CrawlControllerTest do
  use Scrawler.ConnCase

  alias Scrawler.Crawl
  @valid_attrs %{max_depth: 42, max_retries: 42, url: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, crawl_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing crawls"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, crawl_path(conn, :new)
    assert html_response(conn, 200) =~ "New crawl"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, crawl_path(conn, :create), crawl: @valid_attrs
    assert redirected_to(conn) == crawl_path(conn, :index)
    assert Repo.get_by(Crawl, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, crawl_path(conn, :create), crawl: @invalid_attrs
    assert html_response(conn, 200) =~ "New crawl"
  end

  test "shows chosen resource", %{conn: conn} do
    crawl = Repo.insert! %Crawl{}
    conn = get conn, crawl_path(conn, :show, crawl)
    assert html_response(conn, 200) =~ "Show crawl"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, crawl_path(conn, :show, -1)
    end
  end

  test "deletes chosen resource", %{conn: conn} do
    crawl = Repo.insert! %Crawl{}
    conn = delete conn, crawl_path(conn, :delete, crawl)
    assert redirected_to(conn) == crawl_path(conn, :index)
    refute Repo.get(Crawl, crawl.id)
  end
end
