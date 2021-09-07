defmodule IgnitebodyWeb.SchemaTest do
  use IgnitebodyWeb.ConnCase, async: true

  alias Ignitebody.User
  alias Ignitebody.Users.Create

  describe "users query" do
    test "when given a valid id, returns the user", %{conn: conn}  do
      params = %{email: "kakaroto@yahoo.com", name: "Kakaroto", password: "9817239"}

      # Pattern matching para obter o ID do usuário.
      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "kakaroto@yahoo.com",
            "name" => "Kakaroto"
          }
        }
      }

      assert response == expected_response
    end

    test "when given an invalid id, returns an error", %{conn: conn}  do
      # Não é necessário escrever "query { ... }". Já é pressuposto que é uma query.
      query = """
        {
          getUser(id: aaaaaaaaa) {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 13, "line" => 2}],
            "message" => "Argument \"id\" has invalid value aaaaaaaaa."
          }
        ]
      }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when given valid params, creates the user", %{conn: conn} do
      # É necessário escrever "mutation", diferentemente de comandos com query.
      mutation = """
        mutation {
          createUser(input: {
            name: "Pamela",
            email: "alemap@laranja.com",
            password: "123456"
          }) {
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

        # Validação via pattern matching.
        # (O valor retornado para o id está sendo ignorado com "_").
        assert %{
          "data" => %{
            "createUser" => %{
              "id" => _id,
              "name" => "Pamela"
            }
          }
        } = response
    end
  end
end
