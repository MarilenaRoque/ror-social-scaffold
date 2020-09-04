module UsersHelper
  def link_to_invitation(user)
    return unless !current_user.friend?(user) && current_user.id != user.id 
    
    if user.friendship_requested?(current_user)
      link_to 'Accept friendship',  friendship_path(user.friendship(current_user)), method: :patch, class: 'profile-link', name: 'accept' 
    elsif current_user.friendship_requested?(user)
      'pending request'
    else
      link_to 'Invite to friendship', user_friendships_path(user), method: :post, class: 'profile-link', name: 'invite'
    end
  end
end



