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
    def initialize(id)
      super
      @id = id
    end

    def messages
      "A book with book_id: #{@id} is already Uploaded"
    end
  end
end