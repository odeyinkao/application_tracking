defmodule ApplicationTrackingWeb.CandidateDetailLive do
  use ApplicationTrackingWeb, :live_component

  def render(assigns) do
    ~H"""

      <div class="bg-white lg:min-w-0 lg:flex-1">
        <div class="h-full py-6 px-4 sm:px-6 lg:px-8">
          <!-- Start main area-->
          <div class="relative h-full" style="min-height: 36rem;">
            <div class="absolute inset-0 border-2 border-gray-200 border-dashed rounded-lg"></div>
          </div>
          <!-- End main area -->
        </div>
      </div>

    """
  end
end
