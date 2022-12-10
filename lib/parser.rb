# require 'csv'

# module Parser
#   class CsvBookParser
#     def initialize(raw_file)
#       @raw_file = raw_file
#     end
    
#     def parse_input
#       books_attrs = []
#       open_file = File.open(@raw_file)

#       CSV.foreach(open_file, headers: true) do |row|
#         books_attrs << book_attributes(row)
#       end

#       open_file.close
      
#       books_attrs
#     end

#     private

#     def book_attributes(row)
#       book_attrs = row.to_h

#       sanitize_book(book_attrs)

#       {
#         title: book_attrs['Title'],
#         author: book_attrs['Author'],
#         date_published: book_attrs['Date Published'],
#         book_id: book_attrs['Book Id'],
#         publisher_name: book_attrs['Publisher Name']
#       }
#     end

#     def sanitize_book(book_attrs)
#       raise StandardError.new "A book is missing the '#{ book_attrs.key(nil) }' attribute. " \
#       "Please upload a complete CSV file" if book_attrs.has_value?(nil)
#     end
#   end
# end