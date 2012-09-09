
class StandardItem < ActiveRecord::Base
  attr_accessible :item_id, :comments, :project_subtype_id
  belongs_to :project_subtype
  belongs_to :item
  default_scope joins(:item).order('items.name')
  validates :item_id, :presence => true
end
