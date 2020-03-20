FactoryBot.define do
  factory :last_rspec, class: "BaseUser" do
    initialize_with do
      User.new(attributes)
    end
    id { 100000 }
    name {"lol"}
    sequence(:email) { |n| "asda#{n}@ioj.klk" }
    password {"lololol"}
    password_confirmation {"lololol"}
    type {"User"}
    status { 0 }

  end

  factory :first_after_last_rspec, class: "BaseUser" do
    name { "why" }
    email { "should@name.be" }
    type { "User" }
    status { 0 }
  end

  factory :empty_user, class: BaseUser do
  end

  factory :last_after_last_rspec, class: "BaseUser" do
    name { "name" }
    email { "hoho@ho.ho" }
    password { "lastafterlastrspec" }
    password_confirmation { "lastafterlastrspec" }
    status { 0 }
  end

  factory :disabled_user, class: "BaseUser" do
    initialize_with do
      User.new(attributes)
    end
    name { "again" }
    email { "why@should.it" }
    password { "matter" }
    type { "User" }
    password_confirmation { "matter" }
    status { 1 }
  end
end
