defmodule ApplicationTrackingWeb.CandidateComponent do
  use ApplicationTrackingWeb, :live_component

  alias ApplicationTracking.Operation
  alias ApplicationTracking.Operation.Candidate

  def mount(socket) do
    changeset = Operation.change_candidate(%Candidate{})

    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    ~L"""
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
        Candidate Application
      </h2>
      <p class="mt-2 text-center text-sm text-gray-600">
          Provide details and click apply now.
      </p>
    </div>

    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
    <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">

    <%= f = form_for @changeset, "#",
              class: "space-y-6",
              phx_submit: "save",
              phx_change: "validate",
              phx_target: @myself %>

      <div class="field">
        <%= label f , :name,
        class: "block text-sm font-medium text-gray-700" %>
        <%= text_input f, :name,
                        class: "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm",
                        autocomplete: "off",
                        phx_debounce: "blur" %>
        <%= error_tag f, :name %>
      </div>

      <div class="field">
        <%= label f, :email,
        class: "block text-sm font-medium text-gray-700" %>
        <%= text_input f, :email,
        class: "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm",
                        autocomplete: "off",
                        phx_debounce: "1500" %>
        <%= error_tag f, :email %>
      </div>

      <%= submit "Apply Now", phx_disable_with: "Sending Application...",
      class: "w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" %>

      </form>
    </div>
    </div>
    """
  end

  def handle_event("save", %{"candidate" => params}, socket) do
    case Operation.create_candidate(params) do
      {:ok, _} ->
        changeset = Operation.change_candidate(%Candidate{})

        # {:noreply, put_flash(socket, :info, "file #{uploaded_file.name} uploaded")}
        socket = socket
                    |> assign( changeset: changeset)
                    |> put_flash(:info, "Your Application Successfully Created")


        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("validate", %{"candidate" => params}, socket) do
    changeset =
      %Candidate{}
      |> Operation.change_candidate(params)
      |> Map.put(:action, :insert)

    socket = assign(socket, changeset: changeset)

    {:noreply, socket}
  end
end
