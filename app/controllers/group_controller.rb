class GroupController < UICollectionViewController
  attr_accessor :group
  # In app_delegate.rb or wherever you use this controller, just call .new like so:
  #   @window.rootViewController = GroupController.new
  #
  # Or if you're adding using it in a navigation controller, do this
  #  main_controller = GroupController.new
  #  @window.rootViewController = UINavigationController.alloc.initWithRootViewController(main_controller)

  GROUP_CELL_ID = "GroupCell"
  GROUP_SHOT_CELL_ID = "GroupShotCell"

  def self.new(args = {})
    # Set layout
    layout = UICollectionViewFlowLayout.alloc.init
    self.alloc.initWithCollectionViewLayout(layout)
  end

  def viewDidLoad
    super

    self.title = "GroupController"

    @group_shots = []
    fetch_group_shots

    rmq.stylesheet = GroupControllerStylesheet

    collectionView.tap do |cv|
      cv.registerClass(GroupShotCell, forCellWithReuseIdentifier: GROUP_SHOT_CELL_ID)
      cv.delegate = self
      cv.dataSource = self
      cv.allowsSelection = true
      cv.allowsMultipleSelection = false
      rmq(cv).apply_style :collection_view
    end
  end

  def fetch_group_shots
    APIClient.sharedClient.get(API_URL + "/groups/#{@group["id"]}.json") do |response|
      if response.success?
        @group_shots = response.object["group_shots"]
        @users = response.object["users"]

        collectionView.reloadData
      end
    end
  end

  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

  # Remove if you are only supporting portrait
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq(:reapply_style).reapply_styles
  end

  def numberOfSectionsInCollectionView(view)
    1
  end

  def collectionView(view, numberOfItemsInSection: section)
    @group_shots.size
  end

  def collectionView(view, cellForItemAtIndexPath: index_path)
    view.dequeueReusableCellWithReuseIdentifier(GROUP_SHOT_CELL_ID, forIndexPath: index_path).tap do |cell|
      rmq.build(cell) unless cell.reused

      # Update cell's data here
      cell.update(@group_shots[index_path.row])
    end
  end

  def collectionView(view, didSelectItemAtIndexPath: index_path)
    cell = view.cellForItemAtIndexPath(index_path)
    puts "Selected at section: #{index_path.section}, row: #{index_path.row}"
  
    group_shot_controller = GroupShotController.new
    group_shot_controller.group = @group
    group_shot_controller.group_shot = @group_shots[index_path.row]

    self.navigationController.pushViewController(group_shot_controller, animated: true)
  end

end

__END__

# You don't have to reapply styles to all UIViews, if you want to optimize,
# another way to do it is tag the views you need to restyle in your stylesheet,
# then only reapply the tagged views, like so:
def logo(st)
  st.frame = {t: 10, w: 200, h: 96}
  st.centered = :horizontal
  st.image = image.resource('logo')
  st.tag(:reapply_style)
end

# Then in willAnimateRotationToInterfaceOrientation
rmq(:reapply_style).reapply_styles
