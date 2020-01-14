class ApiRegister < ApplicationRecord
  enum api_type: [:public_api, :private_api]

end
