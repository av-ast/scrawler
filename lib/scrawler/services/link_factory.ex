defmodule Scrawler.Services.LinkFactory do
  alias Scrawler.Link
  alias Scrawler.Repo

  def create(params) do
    changeset = Link.changeset(%Link{}, params)

    case Repo.insert(changeset) do
      {:ok, link} ->
        #TODO: make it async (queues, etc...)
        page_title = Scrawler.Screenshoter.make_screenshot(link)
        Link.changeset(link, %{title: page_title}) |> Repo.update
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def screenshot_path(%Link{id: id, user_id: user_id}) do
    Application.get_env(:scrawler, :screenshots_base_path)
    |> Path.join(screenshot_path_suffix(id, user_id))
  end

  def screenshot_url(%Link{id: id, user_id: user_id}) do
    Application.get_env(:scrawler, :screenshots_base_url)
    |> Path.join(screenshot_path_suffix(id, user_id))
  end

  defp screenshot_path_suffix(id, user_id) do
    Path.join(Integer.to_string(user_id), Integer.to_string(id) <> ".png")
  end

end
