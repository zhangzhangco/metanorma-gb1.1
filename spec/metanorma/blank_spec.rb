require_relative "../spec_helper"

RSpec.describe Metanorma::Gb do
  # it "processes a blank document" do
  #   input = <<~INPUT
  #     #{ASCIIDOC_BLANK_HDR}
  #   INPUT
  #   output = <<~OUTPUT
  #     #{BLANK_HDR}
  #     <sections/>
  #   OUTPUT
  #   expect(xmlpp(Asciidoctor.convert(input, *OPTIONS)))
  #     .to be_equivalent_to xmlpp(output)
  # end
  it "converts a blank document to files" do
    input = <<~INPUT
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
      :no-isobib:
    INPUT
    output = <<~OUTPUT
      #{BLANK_HDR}
        <sections/>
      </gb-standard>
    OUTPUT
    expect(xmlpp(Asciidoctor.convert(input, *OPTIONS)))
      .to be_equivalent_to xmlpp(output)
    # expect(File.exist?("test_alt.html")).to be true
    expect(File.exist?("test.html")).to be true
    expect(File.exist?("test.doc")).to be true
    # expect(File.exist?("test.pdf")).to be true
    # expect(File.exist?("htmlstyle.css")).to be false
  end
end
