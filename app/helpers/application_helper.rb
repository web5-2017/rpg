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

  def li_active(*urls)
    body = yield unless body
    active = false

    urls.each do |url|
      if /^#{url}$|^#{url}\?.*/.match(request.fullpath)
        active = true
        break
      end
    end

    if active
      "<li role='presentation' class='active'>#{body}</li>".html_safe
    else
      "<li role='presentation'>#{body}</li>".html_safe
    end
  end
end
