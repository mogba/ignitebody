defmodule Ignitebody.Repo do
  use Ecto.Repo,
    otp_app: :ignitebody,
    adapter: Ecto.Adapters.Postgres
end
