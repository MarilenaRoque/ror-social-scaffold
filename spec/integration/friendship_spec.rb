require 'rails_helper.rb'

describe 'testing friendship features', type: :feature do
  before :each do
    @test_friend = User.create!({ name: 'Marilena',
                                  email: 'girl@gmail.com',
                                  password: '111111',
                                  password_confirmation: '111111' })
    @test_user = User.create!({ name: 'Emanuel',
                                email: 'guy@gmail.com',
                                password: '111111',
                                password_confirmation: '111111' })
    @test_friend_request = User.create!({ name: 'John',
                                          email: 'john@gmail.com',
                                          password: '111111',
                                          password_confirmation: '111111' })
    @friendship = Friendship.create!({ user_id: @test_friend_request.id,
                                       friend_id: @test_user.id,
                                       accepted: nil })

    @post = Post.create!({ user_id: @test_friend_request.id,
                           content: 'Test post from John' })
  end

  ## Creating
  describe 'Creating Requests login with Marilena' do
    before :each do
      visit 'users/sign_in'
      fill_in 'Email', with: 'guy@gmail.com'
      fill_in 'Password', with: '111111'
      click_button 'commit'
      visit 'users'
    end
    it 'login was made' do
      expect(page).to have_content 'Emanuel'
    end
    it 'users is listed in users index' do
      expect(page).to have_content 'Marilena'
    end

    it 'users can send a invite for non-friends' do
      sleep(2)
      click_link 'Invite to friendship'
      expect(page).to have_content 'Invite was successfully sent.'
    end

    it 'Message of Peding Request is displayed' do
      sleep(2)
      click_link 'Invite to friendship'
      expect(page).to have_content 'pending request'
    end

    it 'Resquests are displayed' do
      expect(page).to have_content 'Accept friendship'
    end

    it 'Accept invitation' do
      sleep(2)
      click_link 'Accept friendship'
      expect(page).to have_content 'Friend request was accepted.'
    end

    it 'Accept invitation button dissapears if invitation accepted' do
      sleep(2)
      click_link 'Accept friendship'
      expect(page).to_not have_content 'Accept friendship'
    end

    it 'If friendship was accepted display posts of friends in timeline' do
      visit 'users'
      click_link 'Accept friendship'
      sleep(2)
      visit 'posts'
      expect(page).to have_content 'Test post from John'
    end
  end
end
