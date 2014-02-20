require 'spec_helper'

describe User do

  before :each do
  	@user = User.new(username: 'bammons123', email: 'baileyammons@someplace.com', name: 'Bailey Ammons', password: '1234')
  end

  describe '#username' do
  	it 'Returns the correct username' do
  		@user.username.should eql 'bammons123'
  	end
  end
  describe '#email' do
  	it 'Returns the correct email' do
  		@user.email.should eql 'baileyammons@someplace.com'
  	end
  end
  describe '#name' do
  	it 'Returns the correct name' do
  		@user.name.should eql 'Bailey Ammons'
  	end
  end
  describe '#password' do
  	it 'Returns the correct password' do
  		@user.password.should eql '1234'
  	end
  end
end
