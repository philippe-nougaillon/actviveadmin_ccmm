ActiveAdmin.register Cotation do
  # Specify parameters which should be permitted for assignment
  permit_params :ref, :adherent_id, :intitulé, :mémo, :total_ht

  # or consider:
  #
  # permit_params do
  #   permitted = [:ref, :adherent_id, :intitulé, :mémo, :total_ht]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :ref
  filter :adherent
  filter :intitulé
  filter :mémo
  filter :total_ht
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :ref
    column :adherent
    column :intitulé
    # column :mémo
    column :total_ht
    # column :created_at
    column "modifiée le", :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :ref
      row :adherent
      row :intitulé
      row :mémo
      row :total_ht
      row "crée le", :created_at
      row "modifiée le", :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :ref
      f.input :adherent, member_label: :email
      f.input :intitulé
      f.input :mémo
      f.input :total_ht
    end
    f.actions
  end
end
