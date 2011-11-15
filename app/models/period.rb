class Period < ActiveRecord::Base
  attr_accessible :name, :start_date, :end_date, :active

  validates :name, :start_date, :end_date, :presence => true
  validate :start_date_before_end_date
  validate :start_date_not_in_past

  def start_date_before_end_date
    unless start_date.nil? or end_date.nil?
      unless start_date < end_date
        errors.add(:end_date, "must be after start date")
      end
    end
  end

  def start_date_not_in_past
     unless start_date.nil?
       if start_date < Date.today
        errors.add(:end_date, "cannot be in the past")
       end
    end
  end
end
