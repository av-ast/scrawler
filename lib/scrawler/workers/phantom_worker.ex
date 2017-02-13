defmodule Scrawler.Workers.PhantomWorker do
  use GenServer
  use Hound.Helpers

  alias Hound.Helpers.Screenshot
  alias Scrawler.Link

  @moduledoc """
  This module provides workers for phantomjs web-driver
  """

  @doc false
  def start_link([]) do
    :gen_server.start_link(__MODULE__, [], [])
  end

  def init(state) do
    change_session_to phantom_session_name()
    {:ok, state}
  end

  def handle_cast(%Link{url: url} = link, state) do
    in_browser_session(phantom_session_name(), fn ->
      navigate_to(url)

      link
        |> Link.screenshot_path
        |> prepare_folder
        |> Screenshot.take_screenshot
    end)

    {:noreply, state}
  end

  defp phantom_session_name do
    IO.inspect(self())
  end


  defp prepare_folder(screenshot_path) do
    folder = Path.dirname(screenshot_path)

    unless File.exists?(folder) do
      File.mkdir_p!(folder)
    end

    screenshot_path
  end

end
