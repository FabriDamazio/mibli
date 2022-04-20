defmodule MibliWeb.PageControllerTest do
  use MibliWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Leia mais e melhor com"
    assert html_response(conn, 200) =~ "MIBLI"
  end
end
