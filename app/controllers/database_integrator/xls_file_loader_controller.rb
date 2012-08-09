module DatabaseIntegrator

  class XlsFileLoaderController < DatabaseIntegrator::ApplicationController

    def load_file
      @spreadsheet = Spreadsheet.open(params[:uploaded_file].tempfile)
    end

  end

end
