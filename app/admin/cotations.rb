ActiveAdmin.register Cotation do
  decorate_with CotationDecorator

  # Specify parameters which should be permitted for assignment
  permit_params :ref, :adherent_id, :intitulé, :mémo, :total_ht, :statut, :date_livraison_souhaitée,
                cotation_lignes_attributes: [:id, :cotation_id, :prestation_id, :intitulé, :qté, :prix_ht, :_destroy]

  # or consider:
  #
  # permit_params do
  #   permitted = [:ref, :adherent_id, :intitulé, :mémo, :total_ht]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  page_title = "Cotations / Devis"
  menu label: page_title

  # eliminate N+1 queries
  includes :adherent
  includes :cotation_lignes

  # default sort order 
  config.sort_order = 'updated_at_desc'

  # For security, limit the actions that should be available
  actions :all, except: [:destroy]

  # Add or remove filters to toggle their visibility
  filter :id
  filter :ref
  filter :adherent
  filter :statut, as: :select, collection: proc { Cotation.statuts }
  filter :intitulé
  filter :created_at, label: "Créée le"
  filter :updated_at, label: "Modifiée le"

  # Add or remove columns to toggle their visibility in the index action
  index title: page_title do
    selectable_column
    id_column
    column :ref
    column :statut do |c| 
      status_tag c.statut
    end
    column :adherent, sortable: 'adherent.nom_ville'
    column :intitulé
    column :date_livraison_souhaitée
    column :total_ht
    column "modifiée le", :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show title: page_title do
    attributes_table_for(resource) do
      row :id
      row :ref
      row :statut do
        status_tag resource.statut
      end
      row :adherent
      row :intitulé
      row :mémo
      row :date_livraison_souhaitée
      row :total_ht
      row "créée le", :created_at
      row "modifiée le", :updated_at
      
      panel "Détails des prestations" do
        table_for cotation.cotation_lignes do
          column :id
          column :prestation
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
      f.input :statut
      f.input :mémo
      f.input :date_livraison_souhaitée
      f.input :total_ht
      
      f.inputs "Détails" do
        f.has_many :cotation_lignes, heading: false, allow_destroy: true, new_record: true do |a|
          a.input :prestation
          a.input :intitulé, placeholder: "Pour ajouter un intitulé à la prestation"
          a.input :qté
          a.input :prix_ht
        end
      end
    end
    f.actions
  end

  # CCMM CRM Custom code 
  #
  #

  # Allow statut filters
  scope :all, default: true
  scope("Créé", group: :statut) { |scope| scope.where(statut: 'créé')}
  scope("Envoyé", group: :statut) { |scope| scope.where(statut: 'envoyé')}
  scope("Validé", group: :statut) { |scope| scope.where(statut: 'validé')}
  scope("Refusé", group: :statut) { |scope| scope.where(statut: 'refusé')}
  scope("Archivé", group: :statut) { |scope| scope.where(statut: 'archivé')}

  # PDF generator action_item 
  action_item :pdf, only: :show do
    link_to 'Générer PDF', 
            pdf_admin_cotation_path(resource, format: :pdf),
            class: 'action-item-button',
            title: 'Cliquez ici pour générer la cotation au format PDF'
  end

  # PDF generator action code
  member_action :pdf, method: :get do
    pdf = CotationPdfGenerator.new(resource).generate
    send_data pdf.render,
              filename: "CCMM-Cotation_##{resource.id}.pdf",
              type: 'application/pdf',
              disposition: 'inline'
  end

  # Custom controller
  controller do
    # allow sorting scoped collection (adhérent)
    def scoped_collection
      super.includes :adherent # prevents N+1 queries to the database
    end
  end

  # Batch Actions
  batch_action :archiver, confirm: "Confirmez-vous vouloir faire cette action ?" do |ids|
    batch_action_collection.find(ids).each do |cotation|
      cotation.update(statut: "archivé")
    end
    redirect_to collection_path, alert: "Les éléments sélectionnées ont été archivées..."
  end

end
