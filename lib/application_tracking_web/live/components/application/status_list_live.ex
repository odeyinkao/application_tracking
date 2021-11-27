defmodule ApplicationTrackingWeb.StatusListLive do
  use ApplicationTrackingWeb, :live_component


  def mount(socket) do
    {:ok, assign(socket, status: ["Applied", "Interviewing", "Hired", "Passed"])}
  end

  def render(assigns) do
    IO.inspect(assigns.selected_status)

    ~H"""
      <div class="border-b border-gray-200 xl:border-b-0 xl:flex-shrink-0 xl:w-64 xl:border-r xl:border-gray-200 bg-white">
        <div class="h-full pl-4 pr-6 py-6 sm:pl-6 lg:pl-8 xl:pl-0">

      <fieldset>
        <legend class="text-lg font-medium text-gray-900">Application Status </legend>
        <div class="mt-4 border-t border-b border-gray-200 divide-y divide-gray-200">

          <%= for state <- @status  do %>
            <%= status_item(%{state: state, is_selected: state == @selected_status}) %>
          <% end %>
        </div>
      </fieldset>

          <!-- End left column area -->
        </div>
      </div>
    """
  end

  defp status_item(assigns) do
    ~L"""
      <div class="relative flex items-start py-4">
        <div class="min-w-0 flex-1 text-sm">
          <label for="side-1" class="font-medium text-gray-700 select-none"><%= @state %></label>
        </div>
        <div class="ml-3 flex items-center h-5">
          <input id="side-1" name="plan" type="radio" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300"  <%=(if @is_selected, do: "checked") %>/>
        </div>
      </div>
    """
  end
end
