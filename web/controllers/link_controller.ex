defmodule Scrawler.LinkController do
  use Scrawler.Web, :controller

  alias Scrawler.Link
  alias Scrawler.Services.LinkFactory

  def index(conn, _params) do
    links = Link |> Repo.all() |> Repo.preload([:user])
    render(conn, "index.html", links: links)
  end

  def new(conn, _params) do
    changeset = Link.changeset(%Link{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link" => link_params}) do
    link_params = Map.put(link_params, "user_id", current_user_id(conn))

    case LinkFactory.create(link_params) do
      {:ok, _link} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: link_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Link |> Repo.get!(id) |> Repo.preload([:user])
    render(conn, "show.html", link: link)
  end

  def delete(conn, %{"id" => id}) do
    Repo.get!(Link, id) |> Repo.delete!()

    conn
    |> put_flash(:info, "Link deleted successfully.")
    |> redirect(to: link_path(conn, :index))
  end

  defp current_user_id(conn) do
    conn.assigns.current_user.id
  end
end
