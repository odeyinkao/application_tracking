defmodule ApplicationTrackingWeb.PageController do
  use ApplicationTrackingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
