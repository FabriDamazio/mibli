defmodule Mibli.Accounts do
  use Ash.Domain

  resources do
    resource Mibli.Accounts.Token
    resource Mibli.Accounts.User
  end
end
