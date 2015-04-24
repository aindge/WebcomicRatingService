 module ComicsHelper
	#code i added to make it sort
	def sortable(title, column)
  		css_class = column == sort_column ? "current #{sort_direction}" : nil
  		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
			if params[:search] != nil
  			link_to title, {:sort => column, :direction => direction, :search => params[:search]}, {:class => css_class}
			else
				link_to title, {:sort => column, :direction => direction}, {:class => css_class}
			end
	end
end
