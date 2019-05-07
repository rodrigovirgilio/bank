require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'GET /index' do
    subject { get :index }

    it { is_expected.to render_template(:index) }

    it 'populates an array of customers' do
      customers = create_list :customer, 2

      get :index

      expect(assigns(:customers)).to eq customers
    end
  end

  describe 'GET /new' do
    before { get :new }

    it { is_expected.to render_template(:new) }

    it 'initializing a new customer' do
      expect(assigns(:customer)).to be_a Customer
    end
  end

  describe 'POST /create' do
    subject { post :create, params: { customer: params } }

    context 'with valid params' do
      let(:params) { { name: 'Client one' } }

      it 'creates a new customer' do
        expect { subject }.to change(Customer, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:params) { { name: '' } }

      it 're-renders the new template' do
        expect(subject).to render_template(:new)
      end

      it 'should not create a new customer' do
        expect { subject }.not_to change(Customer, :count)
      end
    end
  end

  describe 'GET /edit' do
    let(:customer) { create :customer }

    before { get :edit, params: { id: customer.id } }

    it { is_expected.to render_template(:edit) }

    it 'initializing the given customer' do
      expect(assigns(:customer)).to be_a(Customer) &
        have_attributes(id: customer.id)
    end
  end

  describe 'PUT /update' do
    let(:customer) { create :customer }

    subject { put :update, params: { id: customer.id, customer: params } }

    context 'with invalid params' do
      let(:params) { { name: '' } }

      it 'should not update the customer' do
        expect { subject }.not_to change(customer, :name)
      end
    end

    context 'with valid params' do
      let(:params) { { name: 'Client one' } }

      it 'updates the customer' do
        expect {
          subject
          customer.reload
        }.to change(customer, :name).to(params[:name])
      end
    end
  end
end
