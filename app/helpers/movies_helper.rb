module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def set_order(column)
    {:order_by => column}
  end
  
  def set_background(column)
    if @order_by == column
      'hilite'
    else
      ''
    end
  end
  
  def checked?(rating)
    if @ratings
  	  @ratings.include? rating
  	else
  	  true
    end
  end
end
