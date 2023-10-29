defmodule GoThimeManager.Repo do
  use Ecto.Repo,
    otp_app: :gothime_manager,
    adapter: Ecto.Adapters.Postgres
end
