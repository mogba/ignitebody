defmodule Ignitebody.Trainings.Create do
  alias Ignitebody.{Repo, Training}

  def call(params) do
    params
    |> Training.changeset()
    |> Repo.insert()
  end
end
