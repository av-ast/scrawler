defmodule Scrawler.LayoutView do
  use Scrawler.Web, :view

  def active_link(conn, text, path) do
    active_link(conn, text, path, "active")
  end

  def active_link(conn, text, path, css_class) do
    content_tag :li, class: active_class(conn, path, css_class) do
      link text, to: path
    end
  end

  def active_class(conn, path, css_class) do
    current_path = conn.request_path
    cond do
      path == current_path ->
        css_class
      String.starts_with?(current_path, path) && path != "/" ->
        css_class
      true ->
        nil
    end
  end

end
