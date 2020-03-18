FactoryBot.define do
  factory :last_rspec, class: "BaseUser" do
    initialize_with do
      User.new(attributes)
    end
    name {"lol"}
    email {"lel@lel.lel"}
    password_digest {"lololol"}
    password_confirmation {"lololol"}
    type {"User"}
    status { 0 }

    # association :first_noti, factory: :notifications
  end

  factory :first_after_last_rspec, class: "BaseUser" do
    name { "why" }
    email { "should@name.be" }
    password_digest { "present" }
    password_confirmation { "present" }
    type { "User" }
    status { 0 }
  end

  factory :last_after_last_rspec, class: "BaseUser" do
    name { "name" }
    email { "hoho@ho.ho" }
    password_digest { "lastafterlastrspec" }
    password_confirmation { "lastafterlastrspec" }
    status { 0 }
  end

  factory :disabled_user, class: "BaseUser" do
    initialize_with do
      User.new(attributes)
    end
    name { "again" }
    email { "why@should.it" }
    password_digest { "matter" }
    type { "User" }
    password_confirmation { "matter" }
    status { 1 }
  end
end
