defmodule Creator.Components.Stage1 do
  use Surface.Component

  alias Surface.Components.Form
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.Label
  alias Surface.Components.Form.Select
  alias Surface.Components.Form.Submit

  prop state, :any, required: true

  def render(assigns) do
    ~H"""
      <Form for={{ :state }} submit="submit_state_1">
        <div>
          Stwórz nową bandę
        </div>
        <Field name="band_type_id">
          <Label/>
          <div class="control">
            <Select options={{ all_bands_for_select() }} opts={{ prompt: ""}} />
          </div>
        </Field>
        <Field name="creator_mode">
          <Label/>
          <div class="control">
            <Select options={{ creator_modes() }} opts={{ prompt: ""}} />
          </div>
         </Field>
         <Submit label="ok!" class="button" />
      </Form>
    """
  end

  defp all_bands_for_select do
    Warheim.Rules.Band.all()
    |> Enum.map(&{&1.name, &1.id})
  end

  defp creator_modes do
    [:import]
  end
end
