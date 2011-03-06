ContactMe.controllers :form do

  get :root, :map => "/" do
    redirect "/admin"
  end

  get(:index, :with => :token) { render_form(:index, params) }
  get(:preview, :with => :token) { render_form(:preview, params) }

  post :create do
    @area = params["area"]
    @area = !!(@area == "preview") ? :preview : :index

    @contact_form = ContactForm.new(params[:contact_form])
    @form = Form.find_by_token(@contact_form.token)
    #area = !!(request.referrer =~ /\/preview\//) ? :preview : :index

    if @contact_form.valid?
      deliver(:contact, :send_message, @form, @contact_form)
      flash[:notice] = "Sua mensagem foi enviada com sucesso."
      redirect url(:form, @area, :token => @contact_form.token)
    else
      flash[:error] = "Nao foi possivel enviar sua mensagem."
      render 'form/show', :layout => (@area == :preview)
    end
  end


end
