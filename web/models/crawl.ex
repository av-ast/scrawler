defmodule Scrawler.Crawl do
  use Scrawler.Web, :model

  use EctoStateMachine,
    states: [:created, :launched, :succeeded, :failed],
    events: [
      [name: :launch, from: [:created], to: :launched],
      [name: :succeed, from: [:launched], to: :succeeded],
      [name: :fail, from: [:launched], to: :failed],
    ]

  schema "crawls" do
    field :url, :string
    field :max_depth, :integer
    field :max_retries, :integer
    field :state, :string, default: "created"

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
