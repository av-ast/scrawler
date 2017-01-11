defmodule Scrawler.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :title, :string
      add :crawl_id, references(:crawls, on_delete: :nothing)

      timestamps()
    end
    create index(:links, [:crawl_id])

  end
end
