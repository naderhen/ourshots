class GroupsCell < UICollectionViewCell
  attr_reader :reused

  def rmq_build
    rmq(self).apply_style :groups_cell

    q = rmq(self.contentView)
    # Add your subviews, init stuff here
    # @foo = q.append(UILabel, :foo).get
    @group_name_label = q.append(UILabel, :group_name_label).get
  end

  def prepareForReuse
    @reused = true
  end

  def update(group)
    @group_name_label.text = group["name"]
  end

end
