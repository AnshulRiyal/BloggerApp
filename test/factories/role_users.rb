# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role_user do
    status "MyString"
    user nil
    role nil
  end
end
