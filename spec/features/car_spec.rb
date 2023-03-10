require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  before(:each) do
    # Authorize_requests
    allow(controller).to receive(:authorize).and_return(true)
  end
  before(:all) do
    @user1 = User.create(name: 'John Jones', email: 'johnjones@gmail.com', password: '12345678',
                         password_confirmation: '12345678')
    @car1 = Car.create(name: 'Tesla Model S', car_type: 'rangerover', description: 'the fastest car in the market',
                       image: 'https://tesla-cdn.thron.com/delivery/public/image/tesla
                       /8a74d206-66dc-4386-8c7a-88ff32174e7d/bvlatuR/std/4096x2560/Mod
                       el-S-Main-Hero-Desktop-LHD', brand: 'Tesla', daily_rate: 2324)
    @car2 = Car.create(name: 'Tesla Model Y', car_type: 'landcruiser',
                       description: 'the fastest car on land in the market', image: 'https://tesla-cdn.thron.com/delivery
                       /public/image/tesla/91abd4c7-32a1-41cc-ade5-b64774dbea61/
                       bvlatuR/std/2880x1800/Model-Y-Main-Hero-D
                       esktop-Global?quality=auto-medium&amp;format=auto', brand: 'Tesla', daily_rate: 3000)
    @car3 = Car.create(name: 'Tesla Model X', car_type: 'speedstar', description: 'the fastest car ever made',
                       image: 'https://tesla-cdn.thron.com/delivery/public/
                       image/tesla/8c26f779-11e5-4cfc-bd7c-
                       dcd03b18ff88/bvlatuR/std/4096x2561/Model-X-Main-Hero-
                       Desktop-LHD', brand: 'Tesla', daily_rate: 1234)
    @car4 = Car.create(name: 'Tesla Model Z', car_type: 'sportscar',
                       description: 'the fastest sportscar in the market', image: 'https://tesla-cdn.thron.com/delivery/
                       public/image/tesla/8a74d206-66dc-4386-8c7a-88ff32174e7d/bvlatuR/std/4096x2560/Model-S-Main-Hero-
                       Desktop-LHD', brand: 'Tesla', daily_rate: 3224)
    Reservation.create(reservation_date: '01-05-2023', due_date: '05-05-2023', user_id: @user1, car_id: @car1)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns all vehicles' do
      cars = Car.all
      get :index
      expect(response.body).to eq(cars.to_json)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: @car1.to_param }
      expect(response).to be_successful
    end

    it 'returns the requested vehicle' do
      get :show, params: { id: @car1.to_param }
      expect(response.body).to eq(@car1.to_json)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'returns a success response' do
        post :create,
             params: { car: { name: 'Tesla Model Y', car_type: 'landcruiser',
                              description: 'the fastest car on land in the market',
                              image: 'https://tesla-cdn.thron.com/delivery/public/image/tesla',
                              brand: 'Tesla', daily_rate: 3000 } }
        expect(response).to be_successful
      end

      it 'creates a new vehicle' do
        expect do
          post :create,
               params: { car: { name: 'Tesla Model Y', car_type: 'landcruiser',
                                description: 'the fastest car on land in the market',
                                image: 'https://tesla-cdn.thron.com/delivery/public/image/tesla',
                                brand: 'Tesla', daily_rate: 3000 } }
        end.to change(Car, :count).by(1)
      end

      it 'returns the created vehicle' do
        post :create,
             params: { car: { name: 'Tesla Model Y', car_type: 'landcruiser',
                              description: 'the fastest car on land in the market',
                              image: 'https://tesla-cdn.thron.com/delivery/public/image/tesla',
                              brand: 'Tesla', daily_rate: 3000 } }
        expect(response.body).to eq(Car.last.to_json)
      end
    end

    context 'with invalid params' do
      it 'does not create a new vehicle' do
        expect do
          post :create,
               params: { car: { name: 'Tesla Model Y', car_type: '', description: '', image: '', brand: '',
                                daily_rate: '' } }
        end.to_not change(Car, :count)
      end

      it 'returns the error messages' do
        post :create,
             params: { car: { name: 'Tesla Model Y', car_type: '', description: '', image: '', brand: '',
                              daily_rate: '' } }
        expect(response.body).to eq(["Description can't be blank", "Brand can't be blank", "Daily rate can't be blank",
                                     'Daily rate is not a number', "Car type can't be blank"].to_json)
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes the requested vehicle' do
        expect do
          delete :destroy, params: { id: @car1.to_param }
        end.to change(Car, :count).by(-1)
      end
    end
  end
end
