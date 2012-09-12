ActiveAdmin.register StandardItem do
  #TODO Active admin sorting is not working, arrows don't show up either.
  controller.authorize_resource
  menu :if => proc{ can?(:manage, StandardItem) },:parent => "Projects"

  form do |f|
    f.inputs "Project Type Details" do
      f.input :project_subtype, :include_blank => false
      f.input :item, :include_blank => false, :as => :select, :collection => Item.materials.alphabetized
      f.input :comments
    end
    f.buttons
  end

  index do
      column :item do |item|
        link_to item.item.name, item_path(item.item_id)
      end
      column "Comments", :comments
      column :project_subtype, :sortable => :project_subtype_id
      default_actions
    end
end
