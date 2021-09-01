defmodule Ignitebody.Users.Create do
  alias Ignitebody.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
