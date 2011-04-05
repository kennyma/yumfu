module ApplicationHelper
  def input_error object, field
    if object.errors[field].any?
      render :partial => 'shared/input_error', :locals => {:field => field, :error_message => object.errors[field]} 
    end
  end
  
  def markdown(txt)
    raw RDiscount.new(txt.to_s, :smart).to_html    
  end      
end
