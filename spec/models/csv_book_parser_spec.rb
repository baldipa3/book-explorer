require 'rails_helper'

RSpec.describe CsvBookParser, type: :model do
  context 'when csv data is complete' do
    let(:file) {'tmp/books_test.csv'}
    let(:parser) { CsvBookParser.new(file) }
    let(:expected_attributes) do
      [
        {
          title: 'The institute',
          author: 'Stephen King',
          date_published: '2019',
          book_id: 'B1',
          publisher_name: 'Hodder'
        },
        {
          title: 'Dreamcatcher',
          author: 'Stephen King',
          date_published: '2001',
          book_id: 'B2',
          publisher_name: 'Scribner'
        }
      ]
    end

    it 'returns the book attributes' do
      expect(parser.parse_input).to eq expected_attributes
    end
  end

  context 'when headers are missing' do
    let(:file) {'tmp/books_test_no_headers.csv'}
    let(:parser) { CsvBookParser.new(file) }
    let(:message) { 'Headers are missing for this file' }

    it 'raises an error with a missing header message' do
      expect { parser.parse_input }.to raise_error(Errors::MissingHeadersError, message)
    end
  end
end
