module ApplicationHelper
  def kind_label(entry)
    entry.credential? ? "Secret" : "Note"
  end
end
