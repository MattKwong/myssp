# == Schema Information
#
# Table name: admin_users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean
#  name                   :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  liaison_id             :integer
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  site_id                :integer
#  user_role_id           :integer
#  username               :string(255)
#  phone                  :string(255)
#  blocked                :boolean
#

class AdminUser < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable,  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :confirmable, :rememberable, :trackable, :validatable

  belongs_to :site

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :user_role, :first_name, :last_name, :site_id,
                  :liaison_id, :password, :password_confirmation, :remember_me

  validates :email, :uniqueness => true
  validates :first_name, :last_name, :user_role, :presence => true
#  validates_inclusion_of :user_role, :in => UserRole.all.map {|i| i.role_name}

  before_save :create_name

  scope :admin, where(:user_role == 'Admin')
  scope :liaison, where(:user_role == 'Liaison')

    def admin?
      self.user_role == "Admin"
    end

    def liaison?
      self.user_role == "Liaison"
    end

    def food_admin?
      self.user_role == "Food Admin"
    end

    def construction_admin?
      self.user_role == "Construction Admin"
    end

  def password_required?
  # Password is required if it is being set, but not for new records
    if !persisted?
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
  # new function to set the password without knowing the current password used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
# new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

# new function to provide access to protected method unless_confirmed
  def only_if_unconfirmed
    unless_confirmed {yield}
  end

  private
  def create_name
    self.name = self.first_name + ' ' + self.last_name
  end

end
