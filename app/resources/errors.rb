module Errors
  class MissingAttributeError < StandardError
    def initialize(attribute)
      super
      @attribute = attribute
    end

    def messages
      "A book is missing the '#{@attribute}' attribute"
    end
  end

  class ValidationError < StandardError
    def initialize(book)
      super
      @book = book
    end

    def messages
      "#{@book.title} with book_id: #{@book.book_id} is already Uploaded"
    end
  end
end