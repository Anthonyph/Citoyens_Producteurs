module ApplicationHelper

  def show_sidebar
    !current_page?(controller: '/home', action: 'index') &&
    !current_page?(controller: '/home', action: 'community') &&
    !current_page?(controller: '/home', action: 'story') &&
    !admin?
  end

  def admin?
    controller.class.name.split("::").first=="Admin"
  end

end
