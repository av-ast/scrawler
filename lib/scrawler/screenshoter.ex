require Logger

defmodule Scrawler.Screenshoter do
  use Hound.Helpers

  alias Hound.Helpers.Screenshot
  alias Scrawler.Link

  def make_screenshot(%Link{id: id, url: url, user_id: user_id}) do
    base_path = Application.get_env(:scrawler, :screenshots_base_path)
    folder = Path.join([base_path, Integer.to_string(user_id)])
    unless File.exists?(folder) do
      File.mkdir_p!(folder)
    end
    save_path = Path.join([folder, Integer.to_string(id) <> ".png"])

    Hound.start_session
    navigate_to(url)
    title = page_title()
    Screenshot.take_screenshot(save_path)
    Hound.end_session

    title
  end

end
