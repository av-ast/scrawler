require Logger

defmodule Scrawler.Screenshoter do
  use Hound.Helpers

  alias Hound.Helpers.Screenshot
  alias Scrawler.Link

  def make_screenshot(%Link{id: id, url: url, user_id: user_id}) do
    base_path = Application.get_env(:scrawler, :screenshots_base_path)
    save_path = Path.join([base_path, user_id, "#{id}.png"])

    try do
      Hound.start_session
      res = navigate_to(url)
      title = page_title()
      Screenshot.take_screenshot("/tmp/123.png")
      Hound.end_session
    rescue
      e -> Logger.error(e)
    end
  end

end
