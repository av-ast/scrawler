defmodule Scrawler.Repo.Migrations.CreateCrawl do
  use Ecto.Migration

  def change do
    create table(:crawls) do
      add :url, :string
      add :max_depth, :integer
      add :max_retries, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:crawls, [:user_id])

  end
end
