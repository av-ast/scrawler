defmodule Scrawler.Link do
  use Scrawler.Web, :model

  schema "links" do
    field :url, :string
    field :title, :string
    field :screenshot_path, :string
    belongs_to :user, Scrawler.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :title, :user_id])
    |> validate_required([:url, :user_id])
  end
end
