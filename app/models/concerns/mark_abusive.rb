module MarkAbusive
  def mark_as_abusive
    update(abusive: true)
  end
end
