ActiveAdmin.register Adherent do
  # Specify parameters which should be permitted for assignment
  permit_params :nom_ville, :nom_contact, :email, :memo

  # or consider:
  #
  # permit_params do
  #   permitted = [:nom_ville, :nom_contact, :email, :memo]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: [:destroy]

  # default sort order 
  config.sort_order = 'nom_ville_asc'

  config.create_another = true

  # Add or remove filters to toggle their visibility
  # filter :id
  filter :nom_ville, as: :select, collection: proc { Adherent.pluck(:nom_ville).uniq.sort }
  filter :nom_contact
  filter :email
  filter :memo
  filter :created_at, label: "Créé le"
  filter :updated_at, label: "Modifié le"

  # Add or remove columns to toggle their visibility in the index action
  index do
    id_column
    column :nom_ville
    column :nom_contact
    column :email
    column "modifié le", :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :nom_ville
      row :nom_contact
      row :email
      row :memo
      row "créé le", :created_at
      row "modifié le", :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :nom_ville
      f.input :nom_contact
      f.input :email
      f.input :memo
    end
    f.actions
  end
end
