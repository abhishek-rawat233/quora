class ReportAbuse < ApplicationRecord

  ###ASSOCIATIONS###
  belongs_to :abusable, polymorphic: true
  belongs_to :base_user

  ###CALLBACKS###
  after_save :check_for_abusive

  ###VALIDATIONS###
  validates :base_user_id, uniqueness: { scope: :abusable}

  def check_for_abusive
    abusable.mark_as_abusive if ReportAbuse.where(abusable_id: abusable_id, abusable_type: abusable_type).count >= REPORT_ABUSIVE_LIMIT
  end
end
