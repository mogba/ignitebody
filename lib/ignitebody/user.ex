defmodule Ignitebody.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ignitebody.Training

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:email, :password, :name]

  schema "users" do
    field :email, :string, null: false
    field :name, :string, null: false
    field :password, :string, null: false

    has_many :trainings, Training

    timestamps()
  end

  # Os parâmetros recebidos serão mapeados/convertidos
  # para os campos definidos na variável de módulo (@fields).
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    # validate_required espera como primeiro argumento uma struct
    # do tipo changeset. cast se encarrega de converter a struct
    # vazio definida acima para que o comando abaixo funcione.
    |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    # O comando acima indica que password deve ter no mínimo 6 caracteres.
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end

  # Exemplo sem Tail Call Optimization:

  def sum([]), do: 0
  def sum([elem]), do: elem

  def sum([head | tail]) do
    head + sum(tail)
  end

  # Exemplo com Tail Call Optimization:

  def sum(list), do: do_sum(list, 0)

  defp do_sum([], _acc), do: 0
  defp do_sum([elem], acc), do: elem + acc

  defp do_sum([head | tail], acc) do
    acc = head + acc
    do_sum(tail, acc)
  end
end
