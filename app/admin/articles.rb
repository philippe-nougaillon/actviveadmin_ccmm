ActiveAdmin.register Article do
  # Specify parameters which should be permitted for assignment
  permit_params :code, :nom, :description, :prix_ht

  # or consider:
  #
  # permit_params do
  #   permitted = [:code, :nom, :description, :prix_ht]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :code
  filter :nom
  filter :description
  filter :prix_ht
  # filter :created_at
  # filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :code
    column :nom
    # column :description
    column :prix_ht
    # column "créé le", :created_at
    column "modifié le", :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :code
      row :nom
      row :description
      row :prix_ht
      row "créé le", :created_at
      row "modifié le", :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :code
      f.input :nom
      f.input :description
      f.input :prix_ht
    end
    f.actions
  end
end
