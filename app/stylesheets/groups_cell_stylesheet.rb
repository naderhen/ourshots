module GroupsCellStylesheet
  def cell_size
    {w: app_width, h: 96}
  end

  def groups_cell(st)
    st.frame = cell_size
    st.background_color = color.random

    # Style overall view here
  end

  def group_name_label(st)
  	st.frame = :full
  end

end
