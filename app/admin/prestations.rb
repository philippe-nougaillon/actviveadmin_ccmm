ActiveAdmin.register Prestation do
  # Specify parameters which should be permitted for assignment
  permit_params :code, :libellé, :catégorie, :sous_catégorie, :description, :unité, :tarif, :compétence, :délai

  # or consider:
  #
  # permit_params do
  #   permitted = [:code, :libellé, :catégorie, :sous_catégorie, :description, :unité, :tarif, :compétence, :délai]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :code
  filter :libellé
  filter :catégorie
  filter :sous_catégorie
  filter :compétence
  filter :délai

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :code
    column :libellé
    column :catégorie
    column :sous_catégorie
    column :unité
    column :tarif
    column :compétence
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :code
      row :libellé
      row :catégorie
      row :sous_catégorie
      row :description
      row :unité
      row :tarif
      row :compétence
      row :délai
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :code
      f.input :libellé
      f.input :catégorie
      f.input :sous_catégorie
      f.input :description
      f.input :unité
      f.input :tarif
      f.input :compétence
      f.input :délai
    end
    f.actions
  end
end
