FactoryBot.define do
    factory :user do
        name {"user"}
        email {"user@xyz.com"}
        password {"123456"}
        password_confirmation {"123456"}
        admin {false}
        soft_delete {false}
    end
end