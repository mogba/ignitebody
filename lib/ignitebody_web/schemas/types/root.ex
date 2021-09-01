defmodule IgnitebodyWeb.Schemas.Types.Root do
  use Absinthe.Schema.Notation

  alias Crudry.Middlewares.TranslateErrors
  alias IgnitebodyWeb.Resolvers.User, as: UserResolver
  alias IgnitebodyWeb.Resolvers.Training, as: TrainingResolver
  alias IgnitebodyWeb.Schemas.Types

  import_types Types.Custom.UUID4
  import_types Types.User
  import_types Types.Training

  object :root_query do
    field :get_user, type: :user do
      arg :id, non_null :uuid4

      resolve &UserResolver.get/2
      # O comando acima é o mesmo que:
      # resolve fn params, context -> UserResolver.get(params, context) end
    end
  end

  object :root_mutation do
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)

      resolve &UserResolver.create/2
      middleware TranslateErrors
    end

    field :create_training, type: :training do
      arg :input, non_null(:create_training_input)

      resolve &TrainingResolver.create/2
      middleware TranslateErrors
    end
  end
end
