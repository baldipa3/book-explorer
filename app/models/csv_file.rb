class CsvFile < ApplicationRecord
  mount_uploader :file, FileUploader
  belongs_to :user
  has_many :books
end
