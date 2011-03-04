Admin.controllers :forms do

  get :index do
    @forms = Form.all
    render 'forms/index'
  end

  get :new do
    @form = Form.new
    render 'forms/new'
  end

  post :create do
    @form = Form.new(params[:form])
    @form.token = current_account.id
    if @form.save
      flash[:notice] = 'Form was successfully created.'
      redirect url(:forms, :edit, :id => @form.id)
    else
      render 'forms/new'
    end
  end

  get :edit, :with => :id do
    @form = Form.find(params[:id])
    render 'forms/edit'
  end

  put :update, :with => :id do
    @form = Form.find(params[:id])
    if @form.update_attributes(params[:form])
      flash[:notice] = 'Form was successfully updated.'
      redirect url(:forms, :edit, :id => @form.id)
    else
      render 'forms/edit'
    end
  end

  delete :destroy, :with => :id do
    form = Form.find(params[:id])
    if form.destroy
      flash[:notice] = 'Form was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Form!'
    end
    redirect url(:forms, :index)
  end
end
