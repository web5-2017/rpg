module ApplicationHelper

  def full_title(title = "")
    return "RPG | #{title}" unless title.empty?

    "RPG"
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def bootstrap_icon_for flash_type
     { success: "ok-circle", error: "remove-circle", alert: "warning-sign", notice: "exclamation-sign" }[flash_type] || "question-sign"
  end

  def li_active(body = nil, url)
    body = yield unless body

    if /^#{url}$/.match(request.fullpath)
      "<li role='presentation' class='active'>#{body}</li>".html_safe
    else
      "<li role='presentation'>#{body}</li>".html_safe
    end
  end
end
