defmodule Ignitebody.Trainings.Get do
  alias Ecto.UUID
  alias Ignitebody.{Repo, Training}

  def call(uuid) do
    uuid
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error) do
    {:error, "Invalid UUID"}
  end

  defp handle_response({:ok, uuid}) do
    case Repo.get(Training, uuid) do
      nil -> {:error, "Training not found"}
      training -> {:ok, training}
    end
  end
end
