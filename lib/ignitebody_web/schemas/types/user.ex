defmodule IgnitebodyWeb.Schemas.Types.User do
  use Absinthe.Schema.Notation

  # O tipo abaixo representa o objeto usuário.
  # É o que poderá ser exibido em uma busca do
  # banco de dados, por exemplo.
  @desc "Logic user representation."
  object :user do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :trainings, list_of(:training)
  end

  # O tipo abaixo é o objeto que define como os
  # deverão ser recebidos dos campos da tela,
  # ou seja, os dados de entrada para criação.
  input_object :create_user_input do
    field :name, non_null(:string), description: "User name"
    field :email, non_null(:string), description: "User email"
    field :password, non_null(:string), description: "User password"
  end
end
