module ApplicationHelper

  def show_sidebar
    !current_page?(controller: '/home', action: 'index') && !admin?
  end

  def admin?
    controller.class.name.split("::").first=="Admin"
  end

end
