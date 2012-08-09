module DatabaseIntegrator::XlsFileLoaderHelper

  def spreadsheet_to_table spreadsheet
    worksheet = spreadsheet.worksheet 0
    table = "<table class='table'>"
    table += %(<thead><tr><th>Selecione os intervalos</th><th colspan='#{worksheet.column_count}'>Conteudo</th></tr></thead>)
    table += "<tbody>"

    0.upto(worksheet.row_count - 1) do |row|

      table += "<tr data-row-number='#{row}'>"
      table += "<td style='cursor: pointer;'><i class='icon-share-alt'></i></td>"

      0.upto(worksheet.column_count - 1) do |col|

        table += "<td>#{worksheet[row,col]}</td>"

      end

      table += "</tr>"

    end

    table += "</tbody>"
    table += "</table>"
    table.html_safe
  end

end