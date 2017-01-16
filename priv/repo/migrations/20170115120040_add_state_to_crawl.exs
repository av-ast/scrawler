defmodule Scrawler.Repo.Migrations.AddStateToCrawl do
  use Ecto.Migration

  def change do
    alter table(:crawls) do
      add :state, :string
    end
  end
end
