defmodule IgnitebodyWeb.Resolvers.Training do
  def create(%{input: params}, _context), do:
    Ignitebody.Trainings.Create.call(params)
end
