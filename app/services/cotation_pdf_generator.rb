# app/services/cotation_pdf_generator.rb
class CotationPdfGenerator
  def initialize(cotation)
    @cotation = cotation
    @pdf = Prawn::Document.new(page_size: 'A4', margin: 50)
  end

  def generate
    add_header
    add_metadata
    #add_content
    add_cotation_details
    add_footer
    @pdf
  end

  private

  def add_header
    @pdf.text "Cotation/Devis CCMM", size: 16 , style: :bold
    @pdf.move_down 10
    @pdf.stroke_horizontal_rule
    @pdf.move_down 20
  end

  def add_metadata
    data = [
      ['Ref:', @cotation.ref],
      ['Adhérent:', @cotation.adherent.nom_ville],
      ['intitulé:', @cotation.intitulé],
      ['Date:', @cotation.updated_at.to_s],
      ['Statut:', @cotation.statut],
      ['Total HT €:', @cotation.total_ht]
    ]

    @pdf.table(data, cell_style: { border_width: 0, padding: 5 }) do
      column(0).font_style = :bold
      column(0).width = 100
    end

    @pdf.move_down 20
  end

  def add_cotation_details
    @pdf.text "Prestations", size: 14, style: :bold

    @pdf.table [['Code', 'Prestation', 'Qté', 'Prix_ht', 'Total_ht']]
    @cotation.cotation_lignes.each do | ligne |
      @pdf.table [[ligne.prestation.code, ligne.prestation.description, ligne.qté, ligne.prix_ht, ligne.total_ht]]      
    end

    # data = [
    #   []
    # ]

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
      @pdf.text "Généré le #{Time.current.strftime('%d/%m/%Y à %H:%M')}",
                size: 8, align: :center
    end
  end
end