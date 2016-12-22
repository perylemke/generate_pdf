require 'prawn'
require 'gruff'

module GeneratePdf
  PDF_OPTIONS = {
    :page_size   => "A4",
    :page_layout => :portrait,
    :margin      => [40, 75]
  }

  def self.agreement name, details, price
    # Text example
    lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec elementum nulla id dignissim iaculis. Vestibulum a egestas elit, vitae feugiat velit. Vestibulum consectetur non neque sit amet tristique. Maecenas sollicitudin enim elit, in auctor ligula facilisis sit amet. Fusce imperdiet risus sed bibendum hendrerit. Sed vitae ante sit amet sapien aliquam consequat. Duis sed magna dignissim, lobortis tortor nec, suscipit velit. Nulla sit amet fringilla nisl. Integer tempor mauris vitae augue lobortis posuere. Ut quis tellus purus. Nullam dolor mauris, egestas varius ligula non, cursus faucibus orci sectetur non neque sit amet tristique. Maecenas sollicitudin enim elit, in auctor ligula facilisis sit amet. Fusce imperdiet risus sed bibendum hendrerit. Sed vitae ante sit amet sapien aliquam consequat."

    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.fill_color "666666"
      pdf.text "Agreement", :size => 32, :style => :bold, :align => :center
      pdf.move_down 80
      pdf.text "#{lorem_ipsum}", :size => 12, :align => :justify, :inline_format => true
      pdf.move_down 30
      pdf.text "#{details}", :size => 12, :align => :justify, :inline_format => true
      pdf.move_down 10
      pdf.text "Com o cliente: <b>#{name}</b> por R$#{price}", :size => 12, :align => :justify, :inline_format => true
      pdf.font "Helvetica"
      pdf.text "Link Para o Manul do Prawn<link href='http://prawnpdf.org/manual.pdf'> <color rgb='5ca3e6'>clicável</color></link>", :size => 10, :inline_format => true, :valign => :bottom, :align => :left
      pdf.number_pages "Gerado: #{(Time.now).strftime("%d/%m/%y as %H:%M")} - Página <page>", :start_count_at => 0, :page_filter => :all, :at => [pdf.bounds.right - 140, 7], :align => :right, :size => 8
      pdf.render_file('public/agreement.pdf')
    end
  end

  def self.spending spendings
    spending_labels = {}
    spendings.each_with_index {|s,i| spending_labels[i] = s[0].to_s}

    g = Gruff::AccumulatorBar.new 1000
    g.hide_legend = true
    g.marker_font_size = 16
    g.theme = {
     :colors => ['#aedaa9', '#12a702'],
     :marker_color => '#dddddd',
     :font_color => 'black',
     :background_colors => 'white'
    }
    g.data 'Savings', spendings.map {|s| s[1]}
    g.labels = spending_labels
    g.write('public/graph.jpg')

    @datasets = spendings
    # Create Gruff object
    g = Gruff::Pie.new 900
    g.theme = Gruff::Themes::PASTEL

    @datasets.each do |data|
      g.data(data[0], data[1])
    end

    # Generate graphic pic
    g.write("public/graph_pie.jpg")

    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.fill_color "666666"
      pdf.text "Gráficos de gastos", :size => 28, :style => :bold, :align => :center
      pdf.move_down 60
      pdf.text "Gráfico em R$ de gastos por setor", size: 14, color: 'AAAAAA', align: :center
      pdf.image "public/graph.jpg", :scale => 0.50
      pdf.number_pages "Gerado: #{(Time.now).strftime("%d/%m/%y as %H:%M")} - Página <page>", :start_count_at => 0, :page_filter => :all, :at => [pdf.bounds.right - 140, 7], :align => :right, :size => 8
      pdf.start_new_page
      pdf.move_down 20
      pdf.text "Gráfico em % de gastos por setor", size: 14, color: 'AAAAAA', align: :center
      pdf.image "public/graph_pie.jpg", :scale => 0.50
      pdf.number_pages "Gerado: #{(Time.now).strftime("%d/%m/%y as %H:%M")} - Página <page>", :start_count_at => 0, :page_filter => :all, :at => [pdf.bounds.right - 140, 7], :align => :right, :size => 8
      pdf.render_file('public/spending.pdf')
    end
  end
end
