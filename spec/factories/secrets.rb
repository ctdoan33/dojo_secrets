FactoryGirl.define do
  factory :secret do
    content "MySecret"
    user
  end
end
