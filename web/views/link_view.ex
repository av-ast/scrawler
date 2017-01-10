defmodule Scrawler.LinkView do
  use Scrawler.Web, :view

  alias Scrawler.Services.LinkFactory

  def screenshot_url(link) do
    LinkFactory.screenshot_url(link)
  end
end
