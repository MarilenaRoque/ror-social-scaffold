class Friendship < ApplicationRecord
    belongs_to :friend_requestor, class_name: 'User'
    belongs_to :friend_requested, class_name: 'User'
end
