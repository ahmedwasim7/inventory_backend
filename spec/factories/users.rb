FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { "Admin-#{User.count.succ}" }
    email { 'admin@admin.com' }
    password { 'admin' }
  end
end
