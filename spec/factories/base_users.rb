FactoryBot.define do
  factory :last_rspec, class: "BaseUser" do
    name {"lol"}
    email {"lel@lel.lel"}
    password_digest {"lololol"}
    password_confirmation {"lololol"}
    type {"User"}
  end

  factory :first_after_last_rspec, class: "BaseUser" do
    name { "why" }
    email { "should@name.be" }
    password_digest { "present" }
    password_confirmation { "present" }
    type { "User" }
  end

  factory :last_after_last_rspec, class: "BaseUser" do
    name { "name" }
    email { "hoho@ho.ho" }
    password_digest { "lastafterlastrspec" }
    password_confirmation { "lastafterlastrspec" }
  end
end
