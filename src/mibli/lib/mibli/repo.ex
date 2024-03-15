defmodule Mibli.Repo do
  use Ecto.Repo,
    otp_app: :mibli,
    adapter: Ecto.Adapters.Postgres
end
