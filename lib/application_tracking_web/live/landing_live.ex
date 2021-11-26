defmodule ApplicationTrackingWeb.LandingLive do
  use ApplicationTrackingWeb, :live_view

  def render(assigns) do
    ~H"""
      <div>
        <%= live_component ApplicationTrackingWeb.CandidateComponent,
                          id: :create_candidate %>
      </div>
    """
  end
end
