defmodule KioskWeb.PageControllerTest do
  use KioskWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    # for now simply assert something renders at root
    assert html_response(conn, 200) =~ ""
  end
end
