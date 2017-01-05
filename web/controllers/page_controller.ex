defmodule Scrawler.PageController do
  use Scrawler.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
