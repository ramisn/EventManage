module ApplicationHelper
  def sortable(column, title=nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    scss_class = (column == sort_column) ? "current #{sort_direction}" : nil
    link_to title, params.merge(:sort => column, :direction => direction), {:class => scss_class, :remote =>true}
  end
end
