defmodule Scrawler.Services.Screenshoter do
  use Hound.Helpers

  alias Hound.Helpers.Screenshot
  alias Scrawler.Link

  @doc """
  Makes screenshot for the given link
  """
  def make_screenshot(%Link{url: url} = link) do
    Hound.start_session
    navigate_to(url)
    title = page_title()

    link
      |> Link.screenshot_path
      |> prepare_folder
      |> Screenshot.take_screenshot

    Hound.end_session
    title
  end

  defp prepare_folder(screenshot_path) do
    folder = Path.dirname(screenshot_path)

    unless File.exists?(folder) do
      File.mkdir_p!(folder)
    end

    screenshot_path
  end

end
