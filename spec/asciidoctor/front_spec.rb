require "spec_helper"

RSpec.describe Asciidoctor::Gb do
  it "processes metadata" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
      = Document title
      Author
      :docfile: test.adoc
      :mandate: mandatory
      :author: Fred Bloggs, Joe Schmoe
      :copyright-year: 1999
      :technical-committee-type: Governance
      :technical-committee: Technical
      :iso-standard: ISO 1012
      :obsoletes: GB/T 134, Source Frequency Regulation
      :obsoletes-parts: Section 3-5
      :scope: national
      :topic: Radio
      :published-date: 2018-01-01
      :library-ccs: 12, 34
      :library-plan: AB
      :author-committee: AC
      :author-committee_2: BC
      :publisher: P
      :authority: Q
      :proposer: X
      :issuer: Y
      :title-intro-en: Title 1
      :title-main-en: Title 2
      :title-part-en: Title 3
      :title-intro-zh: Title 4
      :title-main-zh: Title 5
      :title-part-zh: Title 6
      :docnumber: 123
      :nodoc:
      :novalid:

    INPUT
     <?xml version="1.0" encoding="UTF-8"?>
       <gb-standard xmlns="http://riboseinc.com/gbstandard">
       <bibdata type="standard">
         <title>
           <title-intro language="en" format="plain">Title 1</title-intro>
           <title-main language="en" format="plain">Title 2</title-main>
           <title-part language="en" format="plain">Title 3</title-part>
         </title>
         <title>
           <title-intro language="zh" format="plain">Title 4</title-intro>
           <title-main language="zh" format="plain">Title 5</title-main>
           <title-part language="zh" format="plain">Title 6</title-part>
         </title>
         <docidentifier>
           <project-number>GB 123</project-number>
         </docidentifier>
         <date type="published">
           <on>2018-01-01</on>
         </date>
         <contributor>
           <role type="author"/>
           <person>
             <name>
               <surname>Fred Bloggs</surname>
             </name>
           </person>
         </contributor><contributor><role type="technical-committee"/><organization><name>Technical</name></organization></contributor>
         <contributor>
           <role type="author"/>
           <person>
             <name>
               <surname>Joe Schmoe</surname>
             </name>
           </person>
         </contributor>
         <contributor>
           <role type="author"/>
           <organization>
             <name>AC</name>
           </organization>
         </contributor>
         <contributor>
           <role type="author"/>
           <organization>
             <name>BC</name>
           </organization>
         </contributor>
         <contributor>
           <role type="publisher"/>
           <organization>
             <name>P</name>
           </organization>
         </contributor>
         <contributor>
           <role type="authority"/>
           <organization>
             <name>Q</name>
           </organization>
         </contributor>
         <contributor>
           <role type="proposer"/>
           <organization>
             <name>X</name>
           </organization>
         </contributor>
         <contributor>
           <role type="issuer"/>
           <organization>
             <name>Y</name>
           </organization>
         </contributor>
         <language>zh</language>
         <script>Hans</script>
         <status>
           <stage>60</stage>
           <substage>60</substage>
         </status>
         <copyright>
           <from>1999</from>
           <owner>
             <organization>
               <name>Y</name>
             </organization>
           </owner>
         </copyright>
         <relation type="equivalent">
           <bibitem>
             <title>[not supplied]</title>
             <docidentifier>ISO 1012</docidentifier>
           </bibitem>
         </relation>
         <relation type="obsoletes">
           <bibitem>
             <title> Source Frequency Regulation</title>
             <docidentifier>GB/T 134</docidentifier>
           </bibitem>
           <locality type="section"><referenceFrom>3</referenceFrom><referenceTo>5</referenceTo></locality>
         </relation>
         <gbcommittee type="Governance">Technical</gbcommittee>
         <gbtype>
           <gbscope>national</gbscope>
           <gbprefix>GB</gbprefix>
           <gbmandate>mandatory</gbmandate>
           <gbtopic>Radio</gbtopic>
         </gbtype>
         <ccs>12</ccs>
         <ccs>34</ccs>
         <plannumber>AB</plannumber>
       </bibdata>
       <sections/>
       </gb-standard>
    OUTPUT
  end

  it "processes metadata" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
      = Document title
      Author
      :docfile: test.adoc
      :mandate: recommendation
      :iso-standard: ISO 1012, Televisual Frequencies
      :equivalence: nonequivalent
      :prefix: T/AAA
      :docnumber: 123
      :language: en
      :script: Latn
      :nodoc:
      :novalid:

    INPUT
    <?xml version="1.0" encoding="UTF-8"?>
       <gb-standard xmlns="http://riboseinc.com/gbstandard">
       <bibdata type="recommendation">
         <title>

         </title>
         <title>

         </title>
         <docidentifier>
           <project-number>T/AAA 123</project-number>
         </docidentifier>
         <contributor>
           <role type="author"/>
           <person>
             <name>
               <surname>Author</surname>
             </name>
           </person>
         </contributor><contributor><role type="technical-committee"/><organization><name/></organization></contributor>
         <contributor>
           <role type="author"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="publisher"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="authority"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="proposer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="issuer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <language>en</language>
         <script>Latn</script>
         <status>
           <stage>60</stage>
           <substage>60</substage>
         </status>
         <copyright>
           <from>#{Date.today.year}</from>
           <owner>
             <organization>
               <name>GB</name>
             </organization>
           </owner>
         </copyright>
         <relation type="nonequivalent">
           <bibitem>
             <title> Televisual Frequencies</title>
             <docidentifier>ISO 1012</docidentifier>
           </bibitem>
         </relation>
         <gbcommittee/>
         <gbtype>
           <gbscope>social-group</gbscope>
           <gbprefix>AAA</gbprefix>
           <gbmandate>recommendation</gbmandate>
           <gbtopic>basic</gbtopic>
         </gbtype>
       </bibdata>
       <sections/>
       </gb-standard>
    OUTPUT
  end

  it "processes metadata" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
      = Document title
      Author
      :docfile: test.adoc
      :prefix: Q/Z/BBB
      :docnumber: 123
      :nodoc:
      :novalid:

    INPUT
    <?xml version="1.0" encoding="UTF-8"?>
       <gb-standard xmlns="http://riboseinc.com/gbstandard">
       <bibdata type="standard">
         <title>

         </title>
         <title>

         </title>
         <docidentifier>
           <project-number>Q/BBB 123</project-number>
         </docidentifier>
         <contributor>
           <role type="author"/>
           <person>
             <name>
               <surname>Author</surname>
             </name>
           </person>
         </contributor><contributor><role type="technical-committee"/><organization><name/></organization></contributor>
         <contributor>
           <role type="author"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="publisher"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="authority"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="proposer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="issuer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <language>zh</language>
         <script>Hans</script>
         <status>
           <stage>60</stage>
           <substage>60</substage>
         </status>
         <copyright>
           <from>#{Date.today.year}</from>
           <owner>
             <organization>
               <name>GB</name>
             </organization>
           </owner>
         </copyright>
         <gbcommittee/>
         <gbtype>
           <gbscope>enterprise</gbscope>
           <gbprefix>BBB</gbprefix>
           <gbmandate>mandatory</gbmandate>
           <gbtopic>basic</gbtopic>
         </gbtype>
       </bibdata>
       <sections/>
       </gb-standard>
    OUTPUT
  end

  it "processes metadata" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
      = Document title
      Author
      :docfile: test.adoc
      :mandate: guide
      :docnumber: 123
      :nodoc:
      :novalid:
      :language: en
      :script: Latn

    INPUT
    <?xml version="1.0" encoding="UTF-8"?>
       <gb-standard xmlns="http://riboseinc.com/gbstandard">
       <bibdata type="guide">
         <title>

         </title>
         <title>

         </title>
         <docidentifier>
           <project-number>GB/Z 123</project-number>
         </docidentifier>
         <contributor>
           <role type="author"/>
           <person>
             <name>
               <surname>Author</surname>
             </name>
           </person>
         </contributor><contributor><role type="technical-committee"/><organization><name/></organization></contributor>
         <contributor>
           <role type="author"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="publisher"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="authority"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="proposer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="issuer"/>
           <organization>
             <name>General Administration of Quality Supervision, Inspection and Quarantine; Standardization Administration of China</name>
           </organization>
         </contributor>
         <language>en</language>
         <script>Latn</script>
         <status>
           <stage>60</stage>
           <substage>60</substage>
         </status>
         <copyright>
           <from>#{Date.today.year}</from>
           <owner>
             <organization>
               <name>General Administration of Quality Supervision, Inspection and Quarantine; Standardization Administration of China</name>
             </organization>
           </owner>
         </copyright>
         <gbcommittee/>
         <gbtype>
           <gbscope>national</gbscope>
           <gbprefix>GB</gbprefix>
           <gbmandate>guide</gbmandate>
           <gbtopic>basic</gbtopic>
         </gbtype>
       </bibdata>
       <sections/>
       </gb-standard>
    OUTPUT
  end

  it "processes metadata" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
      = Document title
      Author
      :docfile: test.adoc
      :scope: local
      :prefix: DB81/T
      :docnumber: 123
      :nodoc:
      :novalid:
      :language: en
      :script: Latn

    INPUT
    <?xml version="1.0" encoding="UTF-8"?>
       <gb-standard xmlns="http://riboseinc.com/gbstandard">
       <bibdata type="standard">
         <title>

         </title>
         <title>

         </title>
         <docidentifier>
           <project-number>DB81/123</project-number>
         </docidentifier>
         <contributor>
           <role type="author"/>
           <person>
             <name>
               <surname>Author</surname>
             </name>
           </person>
         </contributor><contributor><role type="technical-committee"/><organization><name/></organization></contributor>
         <contributor>
           <role type="author"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="publisher"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="authority"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="proposer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="issuer"/>
           <organization>
             <name>Hong Kong Special Administrative Region</name>
           </organization>
         </contributor>
         <language>en</language>
         <script>Latn</script>
         <status>
           <stage>60</stage>
           <substage>60</substage>
         </status>
         <copyright>
           <from>#{Date.today.year}</from>
           <owner>
             <organization>
               <name>Hong Kong Special Administrative Region</name>
             </organization>
           </owner>
         </copyright>
         <gbcommittee/>
         <gbtype>
           <gbscope>local</gbscope>
           <gbprefix>81</gbprefix>
           <gbmandate>mandatory</gbmandate>
           <gbtopic>basic</gbtopic>
         </gbtype>
       </bibdata>
       <sections/>
       </gb-standard>
    OUTPUT
  end

  it "processes metadata" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
      = Document title
      Author
      :docfile: test.adoc
      :scope: local
      :prefix: GB/Z
      :docnumber: 123
      :nodoc:
      :novalid:

    INPUT
          <?xml version="1.0" encoding="UTF-8"?>
       <gb-standard xmlns="http://riboseinc.com/gbstandard">
       <bibdata type="standard">
         <title>

         </title>
         <title>

         </title>
         <docidentifier>
           <project-number>DBGB/123</project-number>
         </docidentifier>
         <contributor>
           <role type="author"/>
           <person>
             <name>
               <surname>Author</surname>
             </name>
           </person>
         </contributor><contributor><role type="technical-committee"/><organization><name/></organization></contributor>
         <contributor>
           <role type="author"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="publisher"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="authority"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="proposer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="issuer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <language>zh</language>
         <script>Hans</script>
         <status>
           <stage>60</stage>
           <substage>60</substage>
         </status>
         <copyright>
           <from>#{Date.today.year}</from>
           <owner>
             <organization>
               <name>GB</name>
             </organization>
           </owner>
         </copyright>
         <gbcommittee/>
         <gbtype>
           <gbscope>local</gbscope>
           <gbprefix>GB</gbprefix>
           <gbmandate>mandatory</gbmandate>
           <gbtopic>basic</gbtopic>
         </gbtype>
       </bibdata>
       <sections/>
       </gb-standard>
    OUTPUT
  end

  it "processes metadata" do
    expect(Asciidoctor.convert(<<~"INPUT", backend: :gb, header_footer: true)).to be_equivalent_to <<~"OUTPUT"
      = Document title
      Author
      :docfile: test.adoc
      :scope: local
      :prefix: GB
      :docnumber: 123
      :nodoc:
      :novalid:

    INPUT
    <?xml version="1.0" encoding="UTF-8"?>
       <gb-standard xmlns="http://riboseinc.com/gbstandard">
       <bibdata type="standard">
         <title>

         </title>
         <title>

         </title>
         <docidentifier>
           <project-number>DBGB/123</project-number>
         </docidentifier>
         <contributor>
           <role type="author"/>
           <person>
             <name>
               <surname>Author</surname>
             </name>
           </person>
         </contributor><contributor><role type="technical-committee"/><organization><name/></organization></contributor>
         <contributor>
           <role type="author"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="publisher"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="authority"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="proposer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <contributor>
           <role type="issuer"/>
           <organization>
             <name>GB</name>
           </organization>
         </contributor>
         <language>zh</language>
         <script>Hans</script>
         <status>
           <stage>60</stage>
           <substage>60</substage>
         </status>
         <copyright>
           <from>#{Date.today.year}</from>
           <owner>
             <organization>
               <name>GB</name>
             </organization>
           </owner>
         </copyright>
         <gbcommittee/>
         <gbtype>
           <gbscope>local</gbscope>
           <gbprefix>GB</gbprefix>
           <gbmandate>mandatory</gbmandate>
           <gbtopic>basic</gbtopic>
         </gbtype>
       </bibdata>
       <sections/>
       </gb-standard>
    OUTPUT
  end



end
