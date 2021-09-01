defmodule Ignitebody.IMCTest do
  use ExUnit.Case, async: true

  alias Ignitebody.IMC

  # Teste de lógica de negócio.
  describe "calculate/1" do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
        %{
          "Bruna" => 23.046874999999996,
          "Cristian" => 33.39471302393808,
          "Gabriel" => 22.024322512687924
        }}

      assert response == expected_response
    end

    test "when the wrong filename is given, returns an error" do
      params = %{"filename" => "scholars.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error opening file."}

      assert response == expected_response
    end
  end
end
