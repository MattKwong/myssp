ActiveAdmin::Dashboards.build do

  # The authorization is done using the AdminAbility class

  if proc{ @current_admin_user.admin? } #@current_admin_user.can? :read
     section "Recent System Activity" do
#<<<<<<< HEAD
#      table_for Activity.order("activity_date desc" ).first(100) do
#=======
      table_for Activity.order("activity_date desc").limit(100) do
#>>>>>>> upstream/master
        column :activity_date do |activity|
    activity.activity_date.in_time_zone("Pacific Time (US & Canada)").strftime("%b %d, %Y %l:%M %p")
        end
        column :user_name
        column :activity_type
        column :activity_details
      end
      strong { link_to "View All Activity", admin_activities_path }
    end
  end
end
