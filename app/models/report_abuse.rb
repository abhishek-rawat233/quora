class ReportAbuse < ApplicationRecord

  ###ASSOCIATIONS###
  belongs_to :abusable, polymorphic: true
  belongs_to :base_user

  ###CALLBACKS###
  around_update :set_votes
  after_save :change_netvotes

  ###VALIDATIONS###
  validates :base_user_id, uniqueness: { scope: :abusable}
end
