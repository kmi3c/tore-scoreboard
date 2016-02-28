module ScaffoldHelper
  def resource_name
    params[:controller].singularize
  end
  def resource_class
    resource_name.classify.constantize
  end
  def resources_path
    ['/',resource_name.pluralize].join
  end
  def resource_destroy_path resource
    resource_show_path resource
  end
  def resource_import_path
    [resources_path,'/import'].join
  end
  def resource_show_path resource
    [resources_path,'/',resource.id].join
  end
  def resource_new_path
    [resources_path,'/new'].join
  end
  def resource_edit_path resource
    [resources_path,'/',resource.id,'/edit'].join
  end
end