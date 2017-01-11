defmodule Scrawler.Crawl do
  use Scrawler.Web, :model

  schema "crawls" do
    field :url, :string
    field :max_depth, :integer
    field :max_retries, :integer

    belongs_to :user, Scrawler.User
    has_many :links, Scrawler.Link

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :max_depth, :max_retries, :user_id])
    |> validate_required([:url, :max_depth, :max_retries, :user_id])
  end
end
