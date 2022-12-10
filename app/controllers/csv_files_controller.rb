class CsvFilesController < ApplicationController
  include Errors
  include ExternalServices

  def index
    @csv_files = CsvFile.all
  end

  def show
    @csv_file = current_user.csv_files.find(params[:id])
  end

  def new
  end

  def create
    @uploader = FileUploader.new
    
    begin
      books_attributes = CsvBookParser.new(csv_file_params[:file]).parse_input
      valid_books?(books_attributes)
    rescue ValidationError => e
      flash.now[:messages] = e.messages
      return render :new
    end
    
    @uploader.store!(csv_file_params[:file])

    @csv_file = CsvFile.new(csv_file_attributes)
    @csv_file.save
    
    RequestBin.send_notification(@uploader.url)
    
    persist_books(books_attributes)

    redirect_to csv_file_path(@csv_file)
  end

  private

  def csv_file_params 
    params.permit(:file)
  end

  def csv_file_attributes
    {
      user_id: current_user.id,
      name: csv_file_params[:file].original_filename,
      url: @uploader.url
    }
  end

  def valid_books?(attrs)
    attrs.each do |attr|
      book = Book.find_by book_id: attr[:book_id]

      raise ValidationError.new(attr[:book_id]) if book
    end
    true
  end

  def persist_books(books_attributes)
    books_attributes.each do |book_attrs|
      book = Book.new(book_attrs)
      book.csv_file = @csv_file
      book.save
    end
  end
end