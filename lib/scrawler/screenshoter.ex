require Logger

defmodule Scrawler.Screenshoter do
  use Hound.Helpers

  alias Hound.Helpers.Screenshot

  def make_screenshot(page_url) do
    try do
      Hound.start_session
      res = navigate_to(page_url)
      title = page_title()
      Logger.info("===============")
      Logger.info(inspect(title))
      Logger.info(inspect(res))
      Logger.info("===============")
      Screenshot.take_screenshot("/tmp/123.png")
      Hound.end_session
    rescue
      e -> Logger.error(e)
    end
  end

end
