defmodule Omitestee.API.DocumentControllerTest do
  use OmitesteeWeb.ConnCase
  use Omitestee.Fixtures, [:document]

  alias Omitestee.Document

  describe "POST /api/document" do
    @path "/api/document"

    test "content-type as JSON", %{conn: conn} do
      conn = conn |> post(@path)

      assert [{"content-type", "application/json; charset=utf-8"} | _] =
        conn.resp_headers
    end

    test "valid example", %{conn: conn} do
      body = document_fixture(:valid)
      conn = conn |> post(@path, body)

      document = body |> Document.transform

      assert 200 = conn.status
      assert document = conn.resp_body |> Jason.decode!
    end

    test "invalid format", %{conn: conn} do
      body = %{"test" => 123}
      conn = conn |> post(@path, body)

      assert 422 = conn.status
    end
  end
end
