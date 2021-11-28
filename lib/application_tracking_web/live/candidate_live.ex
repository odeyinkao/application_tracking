defmodule ApplicationTrackingWeb.CandidateLive do
  use ApplicationTrackingWeb, :live_view

  alias ApplicationTracking.Operation


  def mount(_params, _session, socket) do
    selected_status = "Applied"

    socket = assign(socket,
    candidates: Operation.list_candidates(selected_status),
    selected_status: selected_status,
    selected_candidate_id: nil,
    selected_candidate: nil)

    {:ok, socket } # temporary_assigns: [candidates: []]
  end

  # def mount(_params, _session, socket) do
  #   if connected?(socket) do
  #     :timer.send_interval(1000, self(), :update)
  #   end

  #   labels = 1..12 |> Enum.to_list()

  #   values = Enum.map(labels, fn _ -> get_reading() end)

  #   {:ok,
  #    assign(socket,
  #      chart_data: %{
  #        labels: labels,
  #        values: values
  #      },
  #      current_reading: List.last(labels)
  #    )}
  # end

  def render(assigns) do
    ~H"""
      <!-- 3 column wrapper -->
      <div class="flex-grow w-full max-w-7xl mx-auto xl:px-8 lg:flex">
        <!-- Left sidebar & main wrapper -->

        <%= live_component @socket, ApplicationTrackingWeb.StatusListLive,
          selected_status: @selected_status, id: :status_list %>

        <%= live_component @socket, ApplicationTrackingWeb.CandidateListLive,
          selected_status: @selected_status, selected_candidate_id: @selected_candidate_id, candidates: @candidates, id: :candidate_list %>

        <%= live_component @socket, ApplicationTrackingWeb.CandidateDetailLive,
          selected_candidate: @selected_candidate, id: :candidate_details %>

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
    IO.inspect(candidate)

    socket = assign(socket, selected_candidate_id: id, selected_candidate:  candidate )

    {:noreply, socket}

  end
end
