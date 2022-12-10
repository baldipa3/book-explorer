class Book < ApplicationRecord
  belongs_to :csv_file
  validates :book_id, uniqueness: true
end
