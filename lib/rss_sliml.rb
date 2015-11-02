#!/usr/bin/env ruby

# file: rss_sliml.rb


require 'line-tree'
require 'rexle-builder'


class RssSliml

  attr_reader :to_xslt

  def initialize(sliml=nil)

               
    sliml ||= create_sliml()
    @sliml = sliml    


    sliml.gsub!(/\{[^\}]+/) do |x|
      x.gsub(/["']?(\S*)\$(\w+)([^"']*)["']?/,'\'\1{\2}\3\'')
    end
    
    xml = LineTree.new(sliml).to_xml declaration: false, pretty: true
    
    @recxsl = xml.gsub(/<?\$(\w+)(?:\/>)?/, '<xsl:value-of select="\1"/>')
    
    @to_xslt = build_xslt


  end

  def to_sliml()
    
    @sliml
    
  end


  private

  def build_xslt()


    xml = RexleBuilder.new
    raw_a = xml.xsl_stylesheet(xmlns_xsl: \
                    "http://www.w3.org/1999/XSL/Transform", version: "1.1") do
      xml.xsl_output(method: "html", encoding: "utf-8", indent: "yes")

      xml.xsl_template(match: '/') do
        xml.html do
          xml.head do
            xml.title do
              xml.xsl_value_of(select: '/rss/channel/title')
            end
          end
          
          xml.xsl_apply_templates(select: 'rss/channel')
        end
      end      

      xml.xsl_template(match: 'channel') do
        xml.body do
          xml.div do
            xml.xsl_apply_templates(select: 'item')
          end
        end
      end

      xml.xsl_template(match: 'item') do
        xml.rec_template
      end

    end

    xml2 = Rexle.new(raw_a).xml(pretty: true).gsub('xsl_apply_templates',\
        'xsl:apply-templates').gsub('xsl_value_of','xsl:value-of').\
        gsub('xsl_template','xsl:template').\
        gsub('xmlns_xsl','xmlns:xsl').gsub('xsl_for_each','xsl:for-each').\
        gsub('xsl_','xsl:')


    xml2.sub('<rec_template/>', @recxsl)
  end
  
  def create_sliml()
    
"div
  ul
    li
      a {href: '$link'} $title
      div
        $description
"
    
  end  

end
