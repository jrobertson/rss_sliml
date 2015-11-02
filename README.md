# Generating an RSS XML stylesheet using the RSS_sliml gem

    require 'rss_sliml'

    rsss = RssSliml.new 
    rsss.to_xslt

Output:

<pre>
&lt;?xml version='1.0' encoding='UTF-8'?&gt;
&lt;xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.1'&gt;
  &lt;xsl:output method='html' encoding='utf-8' indent='yes'/&gt;
  &lt;xsl:template match='/'&gt;
    &lt;html&gt;
      &lt;head&gt;
        &lt;title&gt;
          &lt;xsl:value-of select='/rss/channel/title'/&gt;
        &lt;/title&gt;
      &lt;/head&gt;
      &lt;xsl:apply-templates select='rss/channel'/&gt;
    &lt;/html&gt;
  &lt;/xsl:template&gt;
  &lt;xsl:template match='channel'&gt;
    &lt;body&gt;
      &lt;div&gt;
        &lt;xsl:apply-templates select='item'/&gt;
      &lt;/div&gt;
    &lt;/body&gt;
  &lt;/xsl:template&gt;
  &lt;xsl:template match='item'&gt;
    &lt;div&gt;
  &lt;ul&gt;
    &lt;li&gt;
      &lt;a href='{link}'&gt;&lt;xsl:value-of select="title"/&gt;&lt;/a&gt;
      &lt;div&gt;
        &lt;xsl:value-of select="description"/&gt;
      &lt;/div&gt;
    &lt;/li&gt;
  &lt;/ul&gt;
&lt;/div&gt;
  &lt;/xsl:template&gt;
&lt;/xsl:stylesheet&gt;
</pre>

    puts rsss.to_sliml

<pre>
div
  ul
    li
      a {href: '{link}'} $title
      div
        $description
</pre>

Note: A Sliml template can optionally be passed into initialization.

## Resources

* rss_sliml https://rubygems.org/gems/rss_sliml

rss_sliml rss sliml xslt
