defmodule IgnitebodyWeb.Resolvers.User do
  # Resolver recebe a requisição e retorna os dados, agindo como ponte.
  def get(%{id: user_id}, _context),
    do: Ignitebody.Users.Get.call(user_id)

  def create(%{input: params}, _context),
    do: Ignitebody.Users.Create.call(params)
end
