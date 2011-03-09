ContactMe.controllers :form do

  get :root, :map => "/" do
    redirect "/admin"
  end

  get(:index, :with => :token) do
    form = Form.find_by_token(params[:token])
    halt(404) and return if form.nil?

    @contact_form = ContactForm.new(:token => form.token)
    render 'form/show'
  end

  post :create do
    @contact_form = ContactForm.new(params[:contact_form])
    @form = Form.find_by_token(@contact_form.token)
    halt(404) and return if @form.nil?

    if @contact_form.valid?
      deliver(:contact, :send_message, @form, @contact_form)
      flash[:notice] = "Sua mensagem foi enviada com sucesso."
      redirect url(:form, :show, :token => @contact_form.token)
    else
      flash[:error] = "Nao foi possivel enviar sua mensagem."
      render 'form/show'
    end
  end


end
