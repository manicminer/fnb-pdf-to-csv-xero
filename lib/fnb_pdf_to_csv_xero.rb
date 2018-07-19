require 'fnb_pdf_to_csv_xero/version'
require 'pdf-reader'
require 'csv'

class FnbPdfToCsvXero
  attr_reader :lines

  AMOUNT = '\(?[0-9]+[, ]?[0-9]*\.[0-9]{2}\)?\s?(Cr)?'
  DATE   = '\d{2} \w{3}'

  def initialize file
    @reader = ::PDF::Reader.new file
    @lines = []
    @year = Time.new.year
  end

  def self.parse file
    parser = self.new(file)
    parser.parse
    parser
  end

  def parse
    @reader.pages.each { |page| parse_page page }
  end

  def output file, separator = ','
    f = File.new file, 'w'
    f.write [
      '*Date','*Amount','Payee','Description','Reference'
    ].to_csv(col_sep: separator)

    lines.each { |line| f.write clean_line(line).to_csv(col_sep: separator) }
  end

  def parse_page page
    page.text.each_line { |line| parse_line line }
  end

  def parse_line line
    line.match(/Statement Period *: .+ ([0-9]{4})/) do |m|
      @year = m[1]
    end
    line.match(/^\s*(#{DATE})(.*?)(#{AMOUNT})(\s+#{AMOUNT})?(\s+#{AMOUNT})?/) do |m|
      @lines.push mangle_line!(m.to_a)
    end
  end

  def clean_date(date)
    day, month = date.split(/\s/)
    Time.new(@year, month, day.to_i).strftime("%Y-%m-%d")
  end

  def clean_amount(amount)
    return amount if amount.nil?
    amount = amount.tr(' ', '')
    return 0 - amount[1..-2].to_f if amount[0] == '(' and amount[-1] == ')'
    if amount[-2..-1] == 'Cr'
      return amount[0..-3].tr(',', '').to_f
    else
      return 0 - amount.tr(',', '').to_f
    end
  end

  def clean_line(line)
    [
      clean_date(line[0]),
      clean_amount(line[4]),
      line[3],
      line[1],
      line[2]
    ]
  end

  def mangle_line! arr
    arr.delete_at 0
    arr.map! { |elm| elm.strip unless elm.nil? } # Cleanup
    arr.delete_at 3
    arr.delete_at 4
    arr.delete_at 5
    arr[1] = arr[1].split(/\s{2,}/) # We get the three descriptions as one string
    arr.insert(2, arr[1][1])        # So split them up and add them back
    arr.insert(3, arr[1][2])
    arr[1] = arr[1][0]
    arr
  end
end
