defmodule Mibli.Secrets do
  use AshAuthentication.Secret

  def secret_for([:authentication, :tokens, :signing_secret], Mibli.Accounts.User, _opts) do
    Application.fetch_env(:mibli, :token_signing_secret)
  end
end
