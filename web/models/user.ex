defmodule Scrawler.User do
  use Scrawler.Web, :model
  alias Passport.Password

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :crawls, Scrawler.Crawl, on_delete: :delete_all
    timestamps()
  end

  def changeset(model, params \\ :empty) do model
    |> cast(params, ~w(email), [])
    |> validate_length(:email, min: 1, max: 150)
    |> validate_length(:name, min: 1, max: 150)
    |> unique_constraint(:email)
  end

  def registration_changeset(model, params) do model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_hashed_password()
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Password.hash(pass))
        _ ->
          changeset
    end
  end

end
