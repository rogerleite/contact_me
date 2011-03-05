ContactMe.controllers :form do

  get(:index, :with => :token) { render_form(:index, params) }
  get(:preview, :with => :token) { render_form(:preview, params) }

  post :create do
    @contact_form = ContactForm.new(params[:contact_form])
    area = !!(request.referrer =~ /\/preview\//) ? :preview : :index

    if @contact_form.valid?
      flash[:notice] = "Sua mensagem foi enviada com sucesso."
      redirect url(:form, area, :token => @contact_form.token)
    else
      flash[:error] = "Nao foi possivel enviar sua mensagem."
      render 'form/show', :layout => (area == :preview)
    end
  end


end
