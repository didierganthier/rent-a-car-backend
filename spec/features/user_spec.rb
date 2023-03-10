require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Authentication' do
    it 'Sings up' do
      expect do
        post :signup,
             params: { user: { email: 'example@gmail.com', password: 123_456, name: 'user 1',
                               password_confirmation: 123_456 } }
      end.to change(User, :count).by 1
    end

    it 'returns a token when Singned up' do
      post :signup, params: { user: { email: 'example@gmail.com', password: 123_456, name: 'user 1' } }
      expect(response.body).to match(/token/)
    end

    it 'log in the user and returns a token' do
      user = User.create(id: 1, name: 'Tom Hanks', email: 'tom@m.com', password: '1234567')
      get :login, params: { user: { email: user.email, password: user.password } }
      expect(response.body).to match(/token/)
    end
  end
end
