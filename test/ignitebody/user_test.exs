defmodule Ignitebody.UserTest do
  use Ignitebody.DataCase, async: true

  alias Ignitebody.User

  # Teste de changeset.
  describe "changeset/1" do
    test "when given params are valid, returns a valid changeset" do
      params = %{name: "Kakaroto", password: "1093822", email: "kakaroto@yahoo.com"}

      response = User.changeset(params)

      # A função assert, neste caso, deve ser executada com o operador de match
      # "=" ao invés do operador de "==" de equivalência, pois a resposta
      # Changeset retornada terá uma estrutura oculta que não seria igual à
      # resposta esperada.
      assert %Ecto.Changeset{
        valid?: true,
        changes: %{email: "kakaroto@yahoo.com", name: "Kakaroto", password: "1093822"},
        errors: []
      } = response
    end

    test "when given invalid params, returns an invalid changeset" do
      params = %{name: "K", email: "kakaroto@yahoo.com"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      # errors_on -> Função de Ignitebody.DataCase que retorna os erros do
      # changeset.
      assert errors_on(response) == expected_response
    end
  end
end
