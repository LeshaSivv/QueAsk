module ApplicationHelper
  def nav_tab(title, url, options = {})
    current_page = options.delete(:current_page)
    css_style = current_page == title ? 'text-secondary' : 'text-white'
    options[:class] =
      if options[:class].present?
        options[:class] + " #{css_style}"
      else
        css_style
      end
    link_to(title, url, options)
  end

  def currently_at(current_page = '')
    render partial: 'shared/navbar', locals: { current_page: current_page }
  end

  def full_title(page_title = '')
    main_title = 'QueAns'
    if page_title.present?
      "#{page_title} ||| #{main_title} "
    else
      main_title
    end
  end
end
