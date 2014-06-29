class GroupShotCell < UICollectionViewCell
  attr_reader :reused

  def rmq_build
    rmq(self).apply_style :group_shot_cell

    q = rmq(self.contentView)
    # Add your subviews, init stuff here
    # @foo = q.append(UILabel, :foo).get
    @group_shot_date_label = q.append(UILabel, :group_shot_date_label).get
  end

  def prepareForReuse
    @reused = true
  end

  def update(group_shot)
    @group_shot_date_label.text = group_shot["date"]
  end

end
