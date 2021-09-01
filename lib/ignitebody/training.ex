defmodule Ignitebody.Training do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ignitebody.{Exercise, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:start_date, :end_date, :user_id]

  schema "trainings" do
    field :start_date, :date
    field :end_date, :date

    belongs_to :user, User
    has_many :exercises, Exercise

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{} # Struct especial/changeset de tipo Ignitebody.Training
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> unique_constraint([:email])
    |> cast_assoc(:exercises)
    # O comando acima executa o changeset das tabelas filhas
    # da tabela atual e faz também suas validações.
  end
end
