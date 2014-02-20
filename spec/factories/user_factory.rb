=begin
This is where the database objects are created for test cases
    use case: create(:user)
    the user is now within the database for that specific test
    look at documentation for factory_girl for more examples
=end

FactoryGirl.define do
    factory :user do
        username 'bammons123'
        email 'baileyammons@someplace.com'
        name 'Bailey Ammons'
        password '12345678'
    end
end
