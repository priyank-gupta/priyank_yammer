module ApplicationHelper

  def not_follow
    users = User.where("id != #{current_user.id}")
    following_users = Follow.where("user_id = #{current_user.id}")
    temp = []
    users.each do |user|
      following_users.each do |following_user|
        if user.id == following_user.follow
          temp.push(user)
        end
      end
    end
    not_following_users = users - temp
  end
end
