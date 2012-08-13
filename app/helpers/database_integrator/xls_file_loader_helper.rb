module DatabaseIntegrator::XlsFileLoaderHelper

  def spreadsheet_to_table spreadsheet
    worksheet = spreadsheet.worksheet 0
    table = "<table class='table'><thead>"
    table += %(<tr><th>Selecione os intervalos</th><th colspan='#{worksheet.column_count}'>Tipo de dado</th></tr>)
    table += %(<tr><th></th>#{ column_types * worksheet.column_count }</tr>)
    table += "</thead><tbody>"

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

  def column_types

    options = [ "Selecione ...", "varchar","integer","float","boolean","date"].map do |datatype|
    "<option value='#{datatype}' >#{datatype}</option>"
    end.join.html_safe

    "<th><select>#{options}</select></th>"
  end

end