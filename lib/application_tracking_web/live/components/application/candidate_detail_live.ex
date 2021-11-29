defmodule ApplicationTrackingWeb.CandidateDetailLive do
  use ApplicationTrackingWeb, :live_component

  alias ApplicationTracking.Operation
  alias ApplicationTracking.Operation.Comment

  def mount(socket) do
    changeset = Operation.change_comment(%Comment{})
    {:ok, assign(socket, changeset: changeset)}
  end


  def render(assigns) do
    ~L"""
    <div class="bg-white lg:min-w-0 lg:flex-1">
      <div class="h-full py-6 px-4 sm:px-6 lg:px-8">

      <div class="lg:col-start-1 lg:col-span-2">
        <!-- Description list-->
        <section aria-labelledby="applicant-information-title">
          <div class="bg-white shadow sm:rounded-lg">
            <div class="px-4 py-5 sm:px-6">
              <h2 id="applicant-information-title" class="text-lg leading-6 font-medium text-gray-900">
                Applicant Information
              </h2>
              <p class="mt-1 max-w-2xl text-sm text-gray-500">
                Personal details and application.
              </p>
            </div>
            <div class="border-t border-gray-200 px-4 py-5 sm:px-6">
              <dl class="grid grid-cols-1 gap-x-4 gap-y-8 sm:grid-cols-2">
                <div class="sm:col-span-1">
                  <dt class="text-sm font-medium text-gray-500">
                    Application Name
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900">
                  <%= @selected_candidate.name %>
                  </dd>
                </div>
                <div class="sm:col-span-1">
                  <dt class="text-sm font-medium text-gray-500">
                    Email address
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900">
                    <%= @selected_candidate.email %>
                  </dd>
                </div>
                <div class="sm:col-span-1">
                  <dt class="text-sm font-medium text-gray-500">
                    Toggle Status
                  </dt>
                  <dd class="mt-1 text-sm text-gray-900">

                    <span class="relative z-0 inline-flex shadow-sm rounded-md">
                      <%= for state <- @status  do %>
                        <button phx-click="set-state" phx-target="<%= @myself %>" phx-value-state="<%= state %>" type="button" class="-ml-px relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 focus:z-10 focus:outline-none focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500">
                          <%= state %>
                        </button>
                      <% end %>
                    </span>
                  </dd>
                </div>
              </dl>
            </div>
          </div>
        </section>

        <!-- Comments-->
        <section aria-labelledby="notes-title">
          <div class="bg-white shadow sm:rounded-lg sm:overflow-hidden">
            <div class="divide-y divide-gray-200">
              <div class="px-4 py-5 sm:px-6">
                <h2 id="notes-title" class="text-lg font-medium text-gray-900">Teams Comment</h2>
              </div>
              <div class="px-4 py-6 sm:px-6">
                <ul role="list" class="space-y-8">

                  <%= for comment <- @selected_candidate.comments  do %>
                    <%= comment_item(%{comment: comment}) %>
                  <% end %>


                </ul>
              </div>
            </div>

            <div class="bg-gray-50 px-4 py-6 sm:px-6">
              <div class="flex space-x-3">
                <div class="flex-shrink-0">
                  <img class="h-10 w-10 rounded-full" src="https://images.unsplash.com/photo-1517365830460-955ce3ccd263?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=256&h=256&q=80" alt="">
                </div>
                <div class="min-w-0 flex-1">
                  <%= f = form_for @changeset, "#",
                  class: "space-y-6",
                  phx_submit: "comment-submit",
                  phx_target: @myself %>


                  <div class="field">
                    <%= label f , :body, class: "sr-only" %>
                    <%= textarea f, :body,
                                    class: "shadow-sm block w-full focus:ring-blue-500 focus:border-blue-500 sm:text-sm border border-gray-300 rounded-md",
                                    placeholder: "Add a feedback here",
                                    phx_debounce: "blur",
                                    rows: "3" %>
                    <%= error_tag f, :body %>
                  </div>


                    <div class="mt-3 flex items-center justify-between">
                      <a href="#" class="group inline-flex items-start text-sm space-x-2 text-gray-500 hover:text-gray-900">
                        <!-- Heroicon name: solid/question-mark-circle -->
                        <svg class="flex-shrink-0 h-5 w-5 text-gray-400 group-hover:text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                          <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
                        </svg>
                        <span>
                          Some few setence is okay.
                        </span>
                      </a>
                      <button type="submit" class="inline-flex items-center justify-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        Comment
                      </button>
                    </div>
                  </form>
                </div>
              </div>
            </div>

          </div>
        </section>
      </div>

      </div>
    </div>

    """
  end

  def handle_event("comment-submit", %{"comment" => %{ "body" => body }}, socket) do
    comment_changes = %{"body" => body, "candidate_id" => socket.assigns.selected_candidate_id, "user_id" => socket.assigns.current_user.id }

    case Operation.create_comment(comment_changes) do
      {:ok, comment} ->
        changeset = Operation.change_comment(%Comment{})

        # {:noreply, put_flash(socket, :info, "file #{uploaded_file.name} uploaded")}
        socket = socket
                    |> assign(changeset: changeset)
                    |> put_flash(:info, "Your Comment Sent Successfully")


        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("set-state", %{"state" => state }, socket) do
    IO.inspect("Here Now Sir")
    comment_changes = %{"status" => state }

    Operation.update_candidate(socket.assigns.selected_candidate, comment_changes)

    {:noreply, socket}
  end

  defp comment_item(assigns) do
    ~L"""
      <li>
        <div class="flex space-x-3">
          <div class="flex-shrink-0">
            <img class="h-10 w-10 rounded-full" src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="">
          </div>
          <div>
            <div class="text-sm">
              <a href="#" class="font-medium text-gray-900"><%= @comment.user.email %></a>
            </div>
            <div class="mt-1 text-sm text-gray-700">
              <p><%= @comment.body%></p>
            </div>
            <div class="mt-2 text-sm space-x-2">
              <span class="text-gray-500 font-medium"><%= to_string(@comment.inserted_at) %></span>
              <span class="text-gray-500 font-medium">&middot;</span>
            </div>
          </div>
        </div>
      </li>
    """
  end

end
