defmodule Ignitebody.Users.Get do
  import Ecto.Query

  alias Ecto.UUID
  alias Ignitebody.{Repo, User, Training}

  # Função pública.
  def call(uuid) do
    uuid
    |> UUID.cast()
    |> handle_response()
  end

  # A função call retorna {:ok, resultado}.
  # A função call! abaixo retorna apenas o resultado.
  # O ponto de exclação é a convenção de nome para funções assim.
  def call!(uuid), do:
    with {:ok, result} <- call(uuid),
      do: result,
      else: (_ -> :error)

  # Função privada.
  defp handle_response(:error) do
    {:error, "Invalid UUID."}
  end

  defp handle_response({:ok, uuid}) do
    # Executa a função Repo.get e se seu retorno for nulo,
    # a função handle_response retorna um erro tratado.
    # Agora se Repo.get retornar o usuário de acordo com o
    # schema User, retorna um OK com o registro.
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found."}
      user -> {:ok, load_training(user)}
    end
  end

  defp load_training(user) do
    today = Date.utc_today()

    # Forma simplificada de criar queries do banco de dados.
    # É necessário importar Ecto.Query.
    query =
      from training in Training,
        where: ^today >= training.start_date and ^today <= training.end_date\
    # O operador pin ^ serve para fixar o valor de uma variável.
    # Ao utiliza-lo, o valor de today, por exemplo, não será
    # alterado em momento algum.

    Repo.preload(user, trainings: { first(query, :inserted_at), :exercises })
  end
end
