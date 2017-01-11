defmodule Scrawler.Link do
  use Scrawler.Web, :model

  alias __MODULE__, as: This

  schema "links" do
    field :url, :string
    field :title, :string
    belongs_to :crawl, Scrawler.Crawl

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :title, :crawl_id])
    |> validate_required([:url, :crawl_id])
  end

  @doc """
  Returns full path to screenshot file
  """
  def screenshot_path(%This{id: id, crawl_id: crawl_id}) do
    Application.get_env(:scrawler, :screenshots_base_path)
    |> Path.join(screenshot_path_suffix(id, crawl_id))
  end

  @doc """
  Returns URL to screenshot file
  """
  def screenshot_url(%This{id: id, crawl_id: crawl_id}) do
    Application.get_env(:scrawler, :screenshots_base_url)
    |> Path.join(screenshot_path_suffix(id, crawl_id))
  end

  defp screenshot_path_suffix(id, crawl_id) do
    Path.join(Integer.to_string(crawl_id), Integer.to_string(id) <> ".png")
  end

end
