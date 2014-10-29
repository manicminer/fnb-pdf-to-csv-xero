#require 'fnb_pdf_to_csv/version'
require 'pdf-reader'
require 'csv'

class FnbPdfToCsv
  attr_reader :lines

  def initialize file
    @reader = ::PDF::Reader.new file
    @lines = []
  end

  def self.parse file
    parser = self.new(file)
    parser.parse
    parser
  end

  def parse
    @reader.pages.each { |page| parse_page page }
  end

  def output file
    f = File.new file, 'w'
    lines.each { |line| f.write line }
  end

  def parse_page page
    page.text.each_line { |line| parse_line line }
  end

  def parse_line line
    line.match(/(\d{2} \w{3})\s{1,2}(.*?)([0-9 ]+\.\d{2})(Cr)?$/) do |m|
      @lines.push mangle_line(m.to_a).to_csv
    end
  end

  def mangle_line arr
    arr[2] = arr[2].split(/\s{2,}/)
    arr.insert(3, arr[2][1])
    arr[2] = arr[2][0]
    arr.delete_at 0
    arr.map! { |elm| elm.strip unless elm.nil? }
    arr[3] = arr[3].sub(/\s/, '') unless arr[3].nil?
    arr
  end
end