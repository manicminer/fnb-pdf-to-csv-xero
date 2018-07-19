# FNB PDF Convert to CSV (for Xero statement import)

This gem helps to convert [FNB][fnb] PDF statements to a CSV format suitable for import into [Xero][xero]

## Installation

Add this line to your application's Gemfile:

    gem 'fnb_pdf_to_csv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fnb_pdf_to_csv

## Usage

Check that you have a recent version of Ruby installed (tested with 2.3.0) and Bundler.

Create a `Gemfile`:

```
source 'https://rubygems.org'
gem 'fnb_pdf_to_csv_xero', :git => 'https://github.com/manicminer/fnb-pdf-to-csv-xero'
```

Install the gem:
```shell
bundle
```

Create a straightforward script to convert:

```ruby
#!/usr/bin/env ruby

require 'fnb_pdf_to_csv_xero'

parser = FnbPdfToCsvXero.parse ARGV[0]
parser.output ARGV[1]
```

Save a PDF statement in the same directory and run the script:
```shell
bundle exec convert.rb filename.pdf filename.csv
```

Import into Xero and profit!

![Screenshot](https://user-images.githubusercontent.com/251987/42947778-581c95bc-8b6e-11e8-9c8b-888d97e77b6d.png)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

This script largely taken from [fnb_pdf_to_csv][fnb_pdf_to_csv] by @jrgns, with only small modifications to change the output format and improve some pattern matching.


[fnb]: https://www.fnb.co.za
[xero]: https://www.xero.com
[fnb_pdf_to_csv]: https://github.com/jrgns/fnb_pdf_to_csv
