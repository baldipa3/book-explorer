class CsvFilesController < ApplicationController
  include Errors

  def new
  end

  def create
    @uploader = FileUploader.new
    
    begin
      books_attributes = CsvBookParser.new(csv_file_params[:file]).parse_input
      persist_books(book_attributes)
    rescue ValidationError => e
      flash.now[:messages] = e.message
      return render :new
    rescue MissingHeadersError => e
      flash.now[:messages] = e.message
      return render :new
    end

    raise
    csv_file = CsvFile.new(csv_file_attributes)

    @uploader.store!(csv_file_params[:file])


    csv_file.save
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

  def persist_books(books_attributes)
    books_attributes.each do |book_attrs|
      book = Book.new(book_attrs)
  
      if book.save
        next
      else
        raise ValidationError.new(book)
      end
    end
  end

  def error_message(e)
    flash.now[:messages] = e.messages
    return render :new  
  end
end