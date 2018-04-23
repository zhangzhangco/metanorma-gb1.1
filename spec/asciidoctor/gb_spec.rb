require "spec_helper"

RSpec.describe Asciidoctor::Gb do
  it "has a version number" do
    expect(Asciidoctor::Gb::VERSION).not_to be nil
  end

  it "generates output for the Rice document" do
    system "cd spec/examples; rm -f rice.doc; rm -f rice.html; asciidoctor --trace -b gb -r 'asciidoctor-gb' rice.adoc; cd ../.."
    expect(File.exist?("spec/examples/rice.doc")).to be true
    expect(File.exist?("spec/examples/rice.html")).to be true
  end

  it "processes a blank document" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
    #{ASCIIDOC_BLANK_HDR}
    INPUT
    #{BLANK_HDR}
<sections/>
</gb-standard>
    OUTPUT
  end

    it "uses Roman fonts" do
    system "rm -f test.doc"
    Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
      :script: Latn
    INPUT
    html = File.read("test.doc", encoding: "utf-8")
    expect(html).to match(%r[p\.Sourcecode[^{]+\{[^{]+font-family: "Courier New", monospace;]m)
    expect(html).to match(%r[p\.Biblio[^{]+\{[^{]+font-family: "Cambria", serif;]m)
    expect(html).to match(%r[\.h2Annex[^{]+\{[^{]+font-family: "Calibri", sans-serif;]m)
    expect(html).to match(%r[\.standard_class[^{]+\{[^{]+font-family: "Cambria", serif;]m)
  end

        it "uses Roman fonts, local scope" do
    system "rm -f test.doc"
    Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
      :script: Latn
      :scope: local
    INPUT
    html = File.read("test.doc", encoding: "utf-8")
    expect(html).to match(%r[p\.Sourcecode[^{]+\{[^{]+font-family: "Courier New", monospace;]m)
    expect(html).to match(%r[p\.Biblio[^{]+\{[^{]+font-family: "Cambria", serif;]m)
    expect(html).to match(%r[\.h2Annex[^{]+\{[^{]+font-family: "Calibri", sans-serif;]m)
    expect(html).to match(%r[\.standard_class[^{]+\{[^{]+font-family: "Calibri", sans-serif;]m)
  end

  it "uses default Chinese fonts" do
    system "rm -f test.doc"
    Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
    INPUT
    html = File.read("test.doc", encoding: "utf-8")
    expect(html).to match(%r[p\.Sourcecode[^{]+\{[^{]+font-family: "Courier New", monospace;]m)
    expect(html).to match(%r[p\.Biblio[^{]+\{[^{]+font-family: "SimSun", serif;]m)
    expect(html).to match(%r[\.h2Annex[^{]+\{[^{]+font-family: "SimHei", sans-serif;]m)
    expect(html).to match(%r[\.standard_class[^{]+\{[^{]+font-family: "SimSun", serif;]m)
  end

    it "uses Chinese fonts, local scope" do
    system "rm -f test.doc"
    Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
      :script: Hans
      :scope: local
    INPUT
    html = File.read("test.doc", encoding: "utf-8")
    expect(html).to match(%r[p\.Sourcecode[^{]+\{[^{]+font-family: "Courier New", monospace;]m)
    expect(html).to match(%r[p\.Biblio[^{]+\{[^{]+font-family: "SimSun", serif;]m)
    expect(html).to match(%r[\.h2Annex[^{]+\{[^{]+font-family: "SimHei", sans-serif;]m)
    expect(html).to match(%r[\.standard_class[^{]+\{[^{]+font-family: "SimHei", sans-serif;]m)
  end

  it "uses specified fonts" do
    system "rm -f test.doc"
    Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
      :script: Hans
      :body-font: Zapf Chancery
      :header-font: Comic Sans
      :monospace-font: Andale Mono
      :title-font: Symbol
    INPUT
    html = File.read("test.doc", encoding: "utf-8")
    expect(html).to match(%r[p\.Sourcecode[^{]+\{[^{]+font-family: Andale Mono;]m)
    expect(html).to match(%r[p\.Biblio[^{]+\{[^{]+font-family: Zapf Chancery;]m)
    expect(html).to match(%r[\.h2Annex[^{]+\{[^{]+font-family: Comic Sans;]m)
    expect(html).to match(%r[\.standard_class[^{]+\{[^{]+font-family: Symbol;]m)
  end



end
