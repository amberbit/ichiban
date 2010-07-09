# encoding: utf-8

module Admin::GenericActions
  def index
    @resources = resource_class.find(:all, sort: ["created_at", "desc"])
  end

  def new
    @resource = resource_class.new
  end

  def create
    @resource = resource_class.new params[resource_name.to_sym]

    if @resource.save
      redirect_to [:admin, @resource]
    else
      flash[:warning] = I18n.t("admin.#{resource_name}.cannot_create")
      render action: "new"
    end
  end

  def update
    if @resource.update_attributes params[resource_name.to_sym]
      redirect_to [:admin, @resource]
    else
      flash[:warning] = I18n.t("admin.#{resource_name}.cannot_update")
      render action: "edit"
    end
  end

  def destroy
    if @resource.destroy
      flash[:notice] = I18n.t("admin.#{resource_name}.deleted")
      redirect_to [:admin, resource_class.to_s.tableize.to_sym]
    else
      flash[:warning] = I18n.t("admin.#{resource_name}.cannot_delete")
      redirect_to :back
    end
  end
  
  def show; end
  def edit; end

  protected

  def resource_name
    resource_class.to_s.underscore
  end
end