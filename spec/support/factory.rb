FactoryGirl.define do

  sequence :email do |t|
    "email_#{t}@email.com"
  end

  factory :user do 
    email  
  end
end