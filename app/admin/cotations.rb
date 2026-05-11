ActiveAdmin.register Cotation do
  # Specify parameters which should be permitted for assignment
  permit_params :ref, :adherent_id, :intitulé, :mémo, :total_ht, :statut,
        cotation_lignes_attributes: [:id, :cotation_id, :article_id, :intitulé, :qté, :prix_ht, :_destroy]

  includes :adherent
  includes :cotation_lignes

  # or consider:
  #
  # permit_params do
  #   permitted = [:ref, :adherent_id, :intitulé, :mémo, :total_ht]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  controller do
    def scoped_collection
      super.includes :adherent # prevents N+1 queries to your database
    end
  end

  # Add or remove filters to toggle their visibility
  filter :id
  filter :ref
  filter :adherent
  filter :statut
  filter :intitulé
  filter :mémo
  filter :total_ht
  filter :created_at, label: "Créée le"
  filter :updated_at, label: "Modifiée le"

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :ref
    column :statut do |c| 
      status_tag c.statut
    end
    column :adherent, sortable: 'adherent.nom_ville'
    column :intitulé
    column :mémo
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
      row :statut do
        status_tag resource.statut
      end
      row :adherent
      row :intitulé
      row :mémo
      row :total_ht
      row "créée le", :created_at
      row "modifiée le", :updated_at
      
      panel "Détails" do
      table_for cotation.cotation_lignes do
        column :id
        column :article
        column :intitulé
        column :qté
        column :prix_ht
        column :total_ht
      end
    end
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :ref
      f.input :adherent
      f.input :intitulé
      f.input :total_ht
      f.input :statut
      f.input :mémo
      
      f.inputs "Détails" do
      f.has_many :cotation_lignes, heading: false, allow_destroy: true, new_record: true do |a|
        a.input :article
        a.input :intitulé
        a.input :qté
        a.input :prix_ht
      end
    end
    end
    f.actions
  end
end
