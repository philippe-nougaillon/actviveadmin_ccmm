ActiveAdmin.register CotationLigne do
  menu false

  # Specify parameters which should be permitted for assignment
  permit_params :cotation_id, :prestation_id, :intitulé, :qté, :prix_ht

  # or consider:
  #
  # permit_params do
  #   permitted = [:cotation_id, :article_id, :intitulé, :qté, :prix_ht]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # eliminate N+1 queries
  includes :prestation

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :cotation
  filter :prestation
  filter :intitulé
  filter :qté
  filter :prix_ht
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :cotation
    column :prestation
    column :intitulé
    column :qté
    column :prix_ht
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :cotation
      row :prestation
      row :intitulé
      row :qté
      row :prix_ht
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :cotation
      f.input :prestation
      f.input :intitulé
      f.input :qté
      f.input :prix_ht
    end
    f.actions
  end
end
