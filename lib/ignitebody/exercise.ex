defmodule Ignitebody.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ignitebody.Training

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [
    :name,
    :youtube_video_url,
    :protocol_description,
    :repetitions
  ]

  schema "exercises" do
    field :name, :string
    field :protocol_description, :string
    field :repetitions, :string
    field :youtube_video_url, :string

    belongs_to :training, Training

    timestamps()
  end

  def changeset(exercise, params) do
    exercise
    |> cast(params, @fields)
    |> validate_required(@fields)
    # Como o changeset de trainings executa o
    # changeset de exercises, o changeset/struct
    # especial será recebido no parâmetro exercise.
  end
end
