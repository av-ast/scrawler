defmodule Scrawler.CrawlController do
  use Scrawler.Web, :controller

  alias Scrawler.Crawl
  alias Scrawler.Factories.CrawlFactory

  def index(conn, _params) do
    crawls = Crawl |> Repo.all |> Repo.preload([:user])
    render(conn, "index.html", crawls: crawls)
  end

  def new(conn, _params) do
    changeset = Crawl.changeset(%Crawl{}, %{max_depth: 0, max_retries: 3})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"crawl" => crawl_params}) do
    crawl_params = Map.put(crawl_params, "user_id", current_user_id(conn))

    case CrawlFactory.create(crawl_params) do
      {:ok, _crawl} ->
        conn
        |> put_flash(:info, "Crawl created successfully.")
        |> redirect(to: crawl_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    crawl = Crawl |> Repo.get!(id) |> Repo.preload([:user])
    render(conn, "show.html", crawl: crawl)
  end

  def delete(conn, %{"id" => id}) do
    Crawl |> Repo.get!(id) |> Repo.delete!()

    conn
    |> put_flash(:info, "Crawl deleted successfully.")
    |> redirect(to: crawl_path(conn, :index))
  end

  defp current_user_id(conn) do
    conn.assigns.current_user.id
  end
end
