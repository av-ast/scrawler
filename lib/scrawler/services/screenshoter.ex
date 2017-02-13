defmodule Scrawler.Services.Screenshoter do

  @doc """
  Makes screenshot of web-page for the given link
  """
  def make_screenshot(link) do
    :poolboy.transaction(:phantom_pool, fn(pid) -> :gen_server.cast(pid, link) end)
  end

end
