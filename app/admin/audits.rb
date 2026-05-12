ActiveAdmin.register Audit do
  menu parent: "_Admin", priority: 9999

  # Specify parameters which should be permitted for assignment
  permit_params :auditable_id, :auditable_type, :associated_id, :associated_type, :user_id, :user_type, :username, :action, :audited_changes, :version, :comment, :remote_address, :request_uuid

  # or consider:
  #
  # permit_params do
  #   permitted = [:auditable_id, :auditable_type, :associated_id, :associated_type, :user_id, :user_type, :username, :action, :audited_changes, :version, :comment, :remote_address, :request_uuid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :auditable
  filter :auditable_type
  filter :associated
  filter :associated_type
  filter :user
  filter :user_type
  filter :username
  filter :action
  filter :audited_changes
  filter :version
  filter :comment
  filter :remote_address
  filter :request_uuid
  filter :created_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :auditable
    column :auditable_type
    column :associated
    column :associated_type
    column :user
    column :user_type
    column :username
    column :action
    column :audited_changes
    column :version
    column :comment
    column :remote_address
    column :request_uuid
    column :created_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :auditable
      row :auditable_type
      row :associated
      row :associated_type
      row :user
      row :user_type
      row :username
      row :action
      row :audited_changes
      row :version
      row :comment
      row :remote_address
      row :request_uuid
      row :created_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :auditable
      f.input :auditable_type
      f.input :associated
      f.input :associated_type
      f.input :user
      f.input :user_type
      f.input :username
      f.input :action
      f.input :audited_changes
      f.input :version
      f.input :comment
      f.input :remote_address
      f.input :request_uuid
    end
    f.actions
  end
end
