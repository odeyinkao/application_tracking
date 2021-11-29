defmodule ApplicationTrackingWeb.CandidateLive do
  use ApplicationTrackingWeb, :live_view

  alias ApplicationTracking.Operation


  def mount(_params, session, socket) do
    selected_status = "Applied"
    status = ["Applied", "Interviewing", "Hired", "Passed"]

    socket = assign(socket,
    candidates: Operation.list_candidates(selected_status),
    selected_status: selected_status,
    selected_candidate_id: nil,
    selected_candidate: nil,
    status: status)

    {:ok, assign_current_user(socket, session)}
    # {:ok, socket } # temporary_assigns: [candidates: []]
  end

  def render(assigns) do
     current_user = assigns[:current_user]
    ~H"""
      <!-- 3 column wrapper -->
      <div class="flex-grow w-full max-w-7xl mx-auto xl:px-8 lg:flex">
        <!-- Left sidebar & main wrapper -->

        <%= live_component @socket, ApplicationTrackingWeb.StatusListLive,
          selected_status: @selected_status, status: @status, id: :status_list %>

        <%= live_component @socket, ApplicationTrackingWeb.CandidateListLive,
          selected_status: @selected_status, selected_candidate_id: @selected_candidate_id, candidates: @candidates, id: :candidate_list %>

        <%= if @selected_candidate do %>
          <%= live_component @socket, ApplicationTrackingWeb.CandidateDetailLive,
          current_user: current_user,  selected_candidate_id: @selected_candidate_id, selected_candidate: @selected_candidate, status: @status, id: :candidate_details %>
        <% end %>

      </div>

    """
  end

  def handle_event("status_selected", %{"status" => status}, socket) do

    candidates = Operation.list_candidates(status);
    socket = assign(socket, selected_status: status, selected_candidate_id: nil, selected_candidate: nil, candidates: candidates)
    {:noreply, socket}

  end

  def handle_event("candidate_selected", %{"id" => id}, socket) do

    candidate = Operation.get_candidate_with_comment!(id);

    socket = assign(socket, selected_candidate_id: id, selected_candidate:  candidate )

    {:noreply, socket}

  end
end
