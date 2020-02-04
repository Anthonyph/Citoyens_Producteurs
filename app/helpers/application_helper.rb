module ApplicationHelper

  def show_sidebar
    !current_page?(controller: '/home', action: 'index') &&
    !current_page?(controller: '/home', action: 'community') &&
    !current_page?(controller: '/home', action: 'story') &&
    !current_page?(controller: '/blog', action: 'index') &&
    !current_page?(controller: '/blog', action: 'new') &&
    !current_page?(controller: '/users/registrations', action: 'new') &&
    !current_page?(controller: '/devise/sessions', action: 'new') &&
    !current_page?(controller: '/devise/sessions', action: 'create') &&
    !current_page?(controller: '/devise/passwords', action: 'new') &&
    !current_page?(controller: '/devise/passwords', action: 'edit') &&
    !admin?
  end

  def admin?
    controller.class.name.split("::").first=="Admin"
  end

end
