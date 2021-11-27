defmodule ApplicationTrackingWeb.CandidateLive do
  use ApplicationTrackingWeb, :live_view

  alias ApplicationTracking.Applicantion


  def mount(_params, _session, socket) do
    selected_status = "Applied"
    {:ok, assign(socket, candidates: Applicantion.list_candidates(selected_status) , selected_status: selected_status, selected_candidate: %{id: nil })}
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

        <%= live_component ApplicationTrackingWeb.StatusListLive,
          selected_status: @selected_status, id: :status_list %>

        <%= live_component ApplicationTrackingWeb.CandidateListLive,
        selected_status: @selected_status, selected_candidate: @selected_candidate, candidates: @candidates, id: :candidate_list %>

        <%= live_component ApplicationTrackingWeb.CandidateDetailLive,
          id: :candidate_details_list %>

      </div>

    """
  end
end
