FactoryGirl.define do

  sequence :email do |t|
    "email_#{t}@email.com"
  end

  sequence :received_at do |t|
    "Sat May 1#{t} 20:02:13 +0000 2013"
  end

  factory :user do 
    email  
  end

  factory :mail do 
    from "example"
    subject "ahoy"
    body "hoy"
    received_at 
    uid "07846"
  end

  factory :tweet do 
  end

  factory :provider do 
    name "google_oauth2"
    uid "1234"
    token "token"
    secret "secret"
  end
end