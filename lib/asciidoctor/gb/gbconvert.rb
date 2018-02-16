require "isodoc"
require_relative "./xref_gen.rb"
require_relative "./metadata.rb"
require_relative "./agencies.rb"
require_relative "./section_output.rb"

module Asciidoctor
  module Gb
    # A {Converter} implementation that generates GB output, and a document
    # schema encapsulation of the document for validation
    class GbConvert < IsoDoc::Convert
      def initialize(options)
        super
      end

      def note_label(node)
        n = get_anchors()[node["id"]]
        return "注" if n.nil?
        n[:label]
      end

      def figure_key(out)
        out.p do |p|
          p.b { |b| b << "Key" } # TODO: Chinese
        end
      end

      def formula_where(dl, out)
        out.p { |p| p << "where" } # TODO: Chinese
        parse(dl, out)
      end

      def figure_get_or_make_dl(t)
        dl = t.at(".//dl")
        if dl.nil?
          t.add_child("<p><b>Key</b></p><dl></dl>") # TODO: Chinese
          dl = t.at(".//dl")
        end
        dl
      end

      def deprecated_term_parse(node, out)
        out.p **{ class: "AltTerms" } do |p|
          p << "DEPRECATED: #{node.text}" #TODO: Chinese
        end
      end

      def termexample_parse(node, out)
        out.div **{ class: "Note" } do |div|
          first = node.first_element_child
          div.p **{ class: "Note" } do |p|
            p << "示例:"
            insert_tab(p, 1)
            para_then_remainder(first, node, p)
          end
        end
      end
      
      # TODO
      LOCALITY = {
      section: "section",
      clause: "clause",
      part: "part",
      paragraph: "paragraph",
      chapter: "chapter",
      page: "page",
      }.freeze

    def eref_localities(r)
      ret = ""
      r.each do |r|
        if r["type"] == "whole"
          ret += ", Whole of text"
        else
          ret += ", #{LOCALITY[r["type"].to_sym]}"
          ref = r.at(ns("./reference"))
          ret += " #{ref.text}" if ref
        end
      end
      ret
    end

      def error_parse(node, out)
        # catch elements not defined in ISO
        case node.name
        when "string" then string_parse(node, out)
        else
          super
        end
      end

      def string_parse(node, out)
        node.children.each { |c| parse(c, out) }
      end

      def fileloc(loc)
        File.join(File.dirname(__FILE__), loc)
      end

      def generate_header(filename, dir)
        header = File.read(@header, encoding: "UTF-8").
          gsub(/FILENAME/, filename).
          gsub(/DOCYEAR/, get_metadata[:docyear]).
          gsub(/DOCIDENTIFIER/, get_metadata[:docidentifier])
        File.open("header.html", "w") do |f|
          f.write(header)
        end
        system "cp #{fileloc(File.join('html', 'blank.png'))} blank.png"
      end
    end
  end
end
