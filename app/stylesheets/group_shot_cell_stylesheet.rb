module GroupShotCellStylesheet
  def cell_size
    {w: 96, h: 96}
  end

  def group_shot_cell(st)
    st.frame = cell_size
    st.background_color = color.random

    # Style overall view here
  end

  def group_shot_date_label(st)
  	st.frame = :full
  end

end
