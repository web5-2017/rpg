module ApplicationHelper

  def full_title(title = "")
    return "RPG | #{title}" unless title.empty?

    "RPG"
  end

end
