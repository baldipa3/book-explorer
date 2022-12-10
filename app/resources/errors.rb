module Errors
  class ValidationError < StandardError
    def initialize(id)
      super
      @id = id
    end

    def message
      "A book with book_id: #{@id} is already Uploaded"
    end
  end

  class MissingHeadersError < StandardError
    def message
      "Headers are missing for this file"
    end
  end
end