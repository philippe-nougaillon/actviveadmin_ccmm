# app/services/cotation_pdf_generator.rb
class CotationPdfGenerator
  include ActionView::Helpers::NumberHelper

  def initialize(cotation)
    @cotation = cotation
    @pdf = Prawn::Document.new(page_size: 'A4', margin: 50)
    @image_path =  "#{Rails.root}/app/assets/images/"
  end

  def generate
    add_header
    add_metadata
    add_cotation_details
    add_footer
    @pdf
  end

  private

  def add_header
    @pdf.image "#{@image_path}/Logo_CC_MAd_et_Moselle.jpg", height:60, position: :right
    @pdf.text "CCMM | Cotation/Devis n°#{ @cotation.id }", size: 16 , style: :bold
    @pdf.move_down 10
    @pdf.stroke_horizontal_rule
    @pdf.move_down 20
  end

  # Informations en entête
  def add_metadata
    data = [
      ['Le :', I18n.l(@cotation.updated_at, format: :long)],
      ['Réf :', @cotation.ref],
      ['Statut :', @cotation.statut.humanize],
      ['Adhérent :', @cotation.adherent.nom_ville],
      ['Intitulé :', @cotation.intitulé],
      ['Livraison : ', I18n.l(@cotation.date_livraison_souhaitée, format: :long)],
      ['Total HT € :', @cotation.total_ht]
    ]

    @pdf.table(data, cell_style: { border_width: 0, padding: 5 }) do
      column(0).font_style = :bold
      column(0).width = 100
    end

    @pdf.move_down 20
  end

  def add_cotation_details
    @pdf.text "Prestations", size: 14, style: :bold
    @pdf.move_down 10

    # Entête de ligne (Titres)
    data = [['Code', 'Intitulé', 'Prix HT €', 'Qté', 'Total HT €']]
    @pdf.table(data, cell_style: { border_width: 1, padding: 5 }) do
      column(0).font_style = :bold
      column(0).width = 50
      column(1).width = 240
      column(2).width = 80
      column(2).align = :center
      column(3).width = 40
      column(3).align = :center
      column(4).width = 80      
      column(4).align = :center
      column(4).font_style = :bold
    end
    @pdf.move_down 10

    # Pour chaque ligne de la cotation
    @cotation.cotation_lignes.each do | ligne |
      data = [
        [ligne.prestation.code, 
        ligne.prestation.description, 
        ligne.prix_ht, 
        ligne.qté, 
        ligne.total_ht]
      ]

      @pdf.table(data, cell_style: { border_width: 0, padding: 5, size: 10 }) do
        column(0).font_style = :bold
        column(0).width = 50
        column(1).width = 240
        column(2).width = 80
        column(2).align = :right
        column(3).width = 40      
        column(3).align = :right
        column(4).width = 80      
        column(4).align = :right
        column(4).font_style = :bold
      end     
    end
  end

  def add_content
    @pdf.text "Mémo", size: 16, style: :bold
    @pdf.move_down 10
    @pdf.text @cotation.mémo, align: :justify
  end

  def add_footer
    @pdf.repeat(:all) do
      @pdf.move_cursor_to 30
      @pdf.stroke_horizontal_rule
      @pdf.move_down 5
      @pdf.text "Document généré le #{Time.current.strftime('%d/%m/%Y à %H:%M')}",
                size: 8, align: :center
    end
  end
end