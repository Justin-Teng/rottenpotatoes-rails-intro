module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def set_background(column)
    if @order_by == column
      'hilite'
    else
      ''
    end
  end
end
