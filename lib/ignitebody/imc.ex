defmodule Ignitebody.IMC do
  # Função que recebe um arquivo como parâmetro.
  def calculate(%{"filename" => filename}) do
    # Para ler o arquivo, utilizar:
    # result = File.read(filename)
    # handle_file(result)

    # Ao invés de ficar atribuindo o retorno das funções para
    # novas variáveis, utiizar o operador pipe, que funciona assim:
    filename
    |> File.read()
    |> handle_file()

    # Se houvesse mais parâmetros, era só passá-los nas funções:
    # |> handle_file(filename2, filename3)
    # O primeiro parâmetro, ou seja, filename, é passado
    # implicitamente para as funções quando o operador pipe
    # é utilizado, e o retorno delas é passado para a próxima função.
  end

  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split("\n")
      |> Enum.map(fn line -> parse_line(line) end)
      |> Enum.into(%{})

    # A linha acima pega no primeiro parâmetro (implícito) a
    # lista de chave e valor com o nome sendo a chave e o IMC
    # já calculado sendo o valor e o transforma em um map com %{}.
    # O resultado é algo como:
    # %{
    #   "Nome1" => 23.437499999999996,
    #   "Nome2" => 22.127499999999996
    # }

    {:ok, data}
  end

  defp handle_file({:error, _reason}) do
    {:error, "Error opening file."}
  end

  # Uma função de reserva que aceita tudo é feita com "_".
  # defp handle_file(_) do
  #   "banana"
  # end

  defp parse_line(line) do
    # Recebe uma lista de handle_file, onde cada elemento
    # contém o nome, a altura e o peso de uma pessoa.
    line
    |> String.trim()
    |> String.split(",")
    # A linha acima transforma os dados de
    # cada pessoa em uma lista de string.
    |> List.update_at(1, &String.to_float/1)
    # A linha acima pega o elemento na
    # posição 1 o converte para float.
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
