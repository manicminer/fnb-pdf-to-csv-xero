# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fnb_pdf_to_csv_xero/version'

Gem::Specification.new do |spec|
  spec.name          = 'fnb_pdf_to_csv_xero'
  spec.version       = FnbPdfToCsvXero::VERSION
  spec.authors       = ['Jurgens du Toit', 'Tom Bamford']
  spec.email         = ['jrgns@jrgns.net', 'tom@bamford.io']
  spec.description   = %(Convert FNB PDF statements to CSV suitable for statement import into Xero. Forked from https://github.com/jrgns/fnb_pdf_to_csv)
  spec.summary       = %(Convert FNB PDF statements to CSV suitable for statement import into Xero. Forked from https://github.com/jrgns/fnb_pdf_to_csv)
  spec.homepage      = 'https://github.com/manicminer/fnb-pdf-to-csv-xero'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'pdf-reader', '~> 1.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rubocop', '~> 0.33'
end
