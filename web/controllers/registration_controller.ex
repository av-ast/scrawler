defmodule Scrawler.RegistrationController do
  use Scrawler.Web, :controller

  alias Scrawler.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> render(:new, changeset: changeset)
  end

  def create(conn, %{"user" => registration_params}) do
    changeset = User.registration_changeset(%User{}, registration_params)
    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Account created!")
        |> redirect(to: welcome_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render(:new, changeset: changeset)
    end
  end

end
