require 'rails_helper.rb'

describe 'testing friendship features', type: :feature do
	before :each do
		@test_friend = User.create!({name: 'Marilena', :email => "girl@gmail.com", :password => "111111", :password_confirmation => "111111" })
    	@test_user = User.create!({name: 'Emanuel', :email => "guy@gmail.com", :password => "111111", :password_confirmation => "111111" })	
	end
	describe 'Creating Requests login with Marilena' do
		before :each do
			visit 'users/sign_in'
	    	fill_in 'Email', with: 'guy@gmail.com'
	      	fill_in 'Password', with: '111111'
	      	click_button 'commit'
		end
		it 'user was created' do
			visit 'users'
			expect(page).to have_content 'Marilena'
		end
	end
end

