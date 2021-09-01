defmodule IgnitebodyWeb.IMCControllerTest do
  use IgnitebodyWeb.ConnCase, async: true

  describe "index/2" do
    test "when given params are valid, returns imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Bruna" => 23.046874999999996,
          "Cristian" => 33.39471302393808,
          "Gabriel" => 22.024322512687924
        }
      }

      assert response == expected_response
    end

    test "when given params are invalid, returns an error", %{conn: conn} do
      params = %{"filename" => "scholars.csv"}

      # imc_path -> Função "helper" da própria
      # ferramenta para este tipo de teste.
      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"result" => "Error opening file."}

      assert response == expected_response
    end
  end
end
