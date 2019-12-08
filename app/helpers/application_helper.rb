module ApplicationHelper

  def show_sidebar
    !current_page?(controller: '/home', action: 'index')
  end

end
