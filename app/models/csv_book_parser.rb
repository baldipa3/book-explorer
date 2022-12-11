require 'csv'

class CsvBookParser
  include Errors

  HEADERS = [
    "Book Id",
    "Title",
    "Author",
    "Date Published",
    "Publisher Name"
  ].freeze

  def initialize(raw_file)
    @raw_file = raw_file
  end
  
  def parse_input
    books_attrs = []
    opened_file = File.open(@raw_file)

    has_headers?(opened_file)

    CSV.foreach(opened_file, headers: true) do |row|
      books_attrs << book_attributes(row)
    end

    opened_file.close
    
    books_attrs
  end

  private

  def book_attributes(row)
    book_attrs = row.to_h

    {
      title: book_attrs['Title'],
      author: book_attrs['Author'],
      date_published: book_attrs['Date Published'],
      book_id: book_attrs['Book Id'],
      publisher_name: book_attrs['Publisher Name']
    }
  end

  def has_headers?(opened_file)
    headers = CSV.read(opened_file, headers: true).headers

    if headers.sort == HEADERS.sort
      true
    else
      raise MissingHeadersError
    end
  end
end
