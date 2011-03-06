
ContactMe.helpers do

  def render_form(area, params)
    @area = area
    begin
      form = Form.find_by_token(params[:token])
      @contact_form = ContactForm.new(:token => form.token)
      render 'form/show', :layout => (@area == :preview)
    rescue ActiveRecord::RecordNotFound
      halt 404
    end
  end

end
