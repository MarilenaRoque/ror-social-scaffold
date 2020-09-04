module UsersHelper
  def link_to_invitation(user)
    if !current_user.friend?(user) && current_user.id != user.id && !current_user.friendship_requested?(user)
		link_to 'Invite to friendship', user_friendships_path(user), method: :post, class: 'profile-link', name: 'invite'
	elsif !current_user.friendship_requested?(user)
		<%= link_to 'Accept',  friendship_path(request), method: :patch, class: 'profile-link' %>
	end
  end
  def
end



