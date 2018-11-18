defmodule Omitestee.SearchControllerTest do
  use OmitesteeWeb.ConnCase
  use Omitestee.Fixtures, [:paginator]

  describe "GET /search" do
    @path "/search"

    test "table with 2 repositories and pagination", %{conn: conn} do
      conn = conn |> get(@path)

      assert conn |> html_response(200) =~ "GitHub Repositories"
      assert conn |> html_response(200) =~ "phoenix"
      assert conn |> html_response(200) =~ "href=\"\/search?page=1\""
    end
  end
end
