class CsvFilesController < ApplicationController

  def new
    @csv_file = CsvFile.new
  end

  def create
    file = csv_file_params[:file]


  end

  private

  def csv_file_params
    params.require(:csv_file).permit(:file)
  end
end
