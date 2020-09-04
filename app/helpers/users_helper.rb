module UsersHelper
  def link_to_invitation(user)
    return unless !current_user.friend?(user) && current_user.id != user.id

    link_to 'Invite to friendship', user_friendships_path(user), method: :post, class: 'profile-link', name: 'invite'
  end
end
