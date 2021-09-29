defmodule LiveBoardWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `GalleryWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, GalleryWeb.PictureLive.FormComponent,
        id: @picture.id || :new,
        action: @live_action,
        picture: @picture,
        return_to: Routes.picture_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, LiveBoardWeb.ModalComponent, modal_opts)
  end

  def generate_card_id() do
    timestamp = DateTime.utc_now() |> DateTime.to_unix(:millisecond)

    random =
      ((:rand.uniform(10_000_000_000_000_000) |> Integer.to_string()) <> "000000000")
      |> String.slice(2..8)

    id = "#{timestamp}#{random}"
    :crypto.hash(:md5, id) |> Base.encode16(case: :lower) |> String.slice(0..15)
  end
end
