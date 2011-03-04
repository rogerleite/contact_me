ContactMe.controllers :form do

  get(:index, :with => :token) { render_form(:index, params) }
  get(:preview, :with => :token) { render_form(:preview, params) }

  post :create do
    contact_form = ContactForm.new(params[:contact_form])

    flash[:notice] = "Obrigado ! Sua mensagem foi enviada."

    area = !!(request.referrer =~ /\/preview\//) ? :preview : :index
    redirect url(:form, area, :token => contact_form.token)
  end


end
