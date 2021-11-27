defmodule ApplicationTrackingWeb.CandidateListLive do
  use ApplicationTrackingWeb, :live_component


  def render(assigns) do
    ~H"""
    <div class=" pr-4 sm:pr-6 lg:pr-8 lg:flex-shrink-0 lg:border-l lg:border-gray-200 xl:border-r-2 bg-white"">

      <div class="h-full pl-6 py-6 lg:w-80">
      <div>
      <h2 class="text-lg leading-6 font-medium text-gray-900">Candidates</h2>
      <p class="mt-1 text-sm text-gray-500">List of <%= @selected_status %> stage.</p>
      <fieldset class="mt-2">
        <legend class="sr-only">Candidate Info</legend>
        <div class="divide-y divide-gray-200">

        <%= for candidate <- @candidates  do %>
          <%= candidate_item(%{candidate: candidate, is_selected: candidate.id == @selected_candidate.id}) %>
        <% end %>


        </div>
      </fieldset>
      </div>


      </div>
    </div>
    """
  end

  defp candidate_item(assigns) do
    ~L"""
      <div class="relative flex items-start py-4">
        <div class="min-w-0 flex-1 text-sm">
          <label for="account-savings" class="font-medium text-gray-700"><%= @candidate.name %></label>
          <p id="account-savings-description" class="text-gray-500"><%= @candidate.email %></p>
        </div>
        <div class="ml-3 flex items-center h-5">
          <input id="account-savings" aria-describedby="account-savings-description" name="account" type="radio" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300" <%=(if @is_selected, do: "checked") %>/>
        </div>
      </div>
    """
  end
end
