require 'rubygems'
require 'open-uri'
require 'Hpricot'
require 'yaml'



def scan_for_first(str, regex)
  if (str =~ regex)
    match = str.scan(regex).first
    match[0] #the index refers to the first capture of ()
  else
    ''
  end
end

def scan_for_phone(str)
  scan =  scan_for_first str, /([0-9]{3}-[0-9]{3}-[0-9]{4})/

  unless scan.empty? then scan else '' end
end


def scan_for_email(str)
  scan =  scan_for_first str, /([0-9a-z][0-9a-z.+]+[0-9a-z]@[0-9a-z][0-9a-z.-]+[0-9a-z])/

  unless scan.empty? then scan else '' end
end


def scan_for_website(str)
  scan = ''
  scan =  scan_for_first(str, /\s([0-9a-z][0-9a-z.+]{5,}[0-9a-z])\s/) if str =~ /\./

  unless scan.empty? then scan else '' end
end





@rooturl = "http://www.rollerskating.org/locator/"
@url = @rooturl + "srchresultrink.asp"

@rink_details_url = "rinkdetails.asp?membershipid="

@response = ''

# open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
open(@url,
     #"User-Agent" => "Ruby/#{RUBY_VERSION}",
    "User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1",
    "Referer" => "http://www.vanillaskateco.com/") { |f|
    puts "Fetched document: #{f.base_uri}"
    puts "\\t Content Type: #{f.content_type}\\n"
    puts "\\t Charset: #{f.charset}\\n"
    puts "\\t Content-Encoding: #{f.content_encoding}\\n"
    puts "\\t Last Modified: #{f.last_modified}\\n\\n"

    # Save the response body
    @response = f.read
}

#puts @response
doc = Hpricot(@response)

#puts (doc/xpath_root).inner_html
#puts (doc/"/html/body/table/tbody/tr/td/table/tbody/tr[5]/td/table/tbody/tr/td/table/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/").inner_html
#puts (doc/"/html/body/table/").inner_html

#puts (doc/xpath_root).inner_html
#puts (doc/a).first.inner_html

mem_ids = []

p("Here are the links inside of this web page:")
doc.search("a").each{ |e|
  #p(e.to_html)
  link = e.attributes["href"]

  if (link =~ /membershipid=(.*)/)
    match = link.scan(/membershipid=(.*)/).first
    id = match[0] #the index refers to the first capture of ()

    mem_ids.push id unless ((id == '123456' || id == 'test001' || id == 'RS001' || id == 'MD054') || (mem_ids.include? id))
  end
}

puts 'done getting member ids'

members = {}
#mem_ids[0..6].each { |m|
mem_ids.each { |m|
  thisrinkurl = @rooturl + @rink_details_url + m

  members[m] =  { 'url' => thisrinkurl } #puts members[m][:url]
}

puts 'done with each url'



#m = mem_ids[0]
#mem_ids[0..6].each { |m|
mem_ids.each { |m|
  # open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html

  puts members[m]['url']
  open(members[m]['url'],
       #"User-Agent" => "Ruby/#{RUBY_VERSION}",
      "User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1",
      "Referer" => "http://www.vanillaskateco.com/") { |f|
      puts "Fetched document: #{f.base_uri}"
      puts "\\t Content Type: #{f.content_type}\\n"
      puts "\\t Charset: #{f.charset}\\n"
      puts "\\t Content-Encoding: #{f.content_encoding}\\n"
      puts "\\t Last Modified: #{f.last_modified}\\n\\n"

      # Save the response body
      @response = f.read
  }

  rink_page = Hpricot(@response)
  rink_table_xpath = '/html/body/table'
  td_xpath = 'tr/td'

  rink_table = (rink_page/rink_table_xpath).inner_html
  rink_table = Hpricot(rink_table)

  #puts(rink_table.search("p").first.inner_html)
  rinkname = (rink_table.search("p").first.inner_html.strip)
  members[m]['name'] = rinkname.gsub("<br />", "")
  members[m]['description'] = m

  rink_table_search = rink_table.search("a")

  addresslink = (rink_table_search.first.attributes["href"])

  address = {
    'line_one' => (scan_for_first addresslink, /address=(.*)&zip=/),
    'line_two' => '',
    'city' => (scan_for_first addresslink, /city=(.*)&state=/),
    'state' => (scan_for_first addresslink, /state=(.*)&address=/),
    'zip' => (scan_for_first addresslink, /zip=(.*)&zoom=/)
  }

  members[m]['phone'] = ''
  members[m]['website'] = ''
  members[m]['email'] = ''

  #remove the first link
  rink_table_search.delete_at 0
  if (rink_table_search.first) then
    members[m]['website'] = rink_table_search.first.attributes["href"]
  end

  rink_page.search(td_xpath).each{ |td|
    phone = scan_for_phone(td.inner_html)
    email = scan_for_email(td.inner_html)
    website = scan_for_website(td.inner_html)

    unless phone.empty? then members[m]['phone'] = phone end
    #unless website.empty? then members[m]['website'] = website end
    unless email.empty? then members[m]['email'] = email end
    }

  members[m]['address'] = address

  members[m].delete('url')

#  if (link =~ /membershipid=(.*)/)
#    match = link.scan(/membershipid=(.*)/).first
#    id = match[0] #the index refers to the first capture of ()
#
#    mem_ids.push id unless (id == '123456' || id == 'test001' || id == 'RS001' || id == 'MD054')
#  end

  puts scan_for_first members[m]['address-link'], /city=(.*)&state=/
}

#mem_ids[0..5].each { |m|
  #puts m + ": " + members[m][:name]
#  puts ''
#  puts m + ': '
#  puts members[m].to_yaml
#}

file = File.new("rinks.yml", "w+")
if file
   file.syswrite(members.to_yaml)
else
   puts "Unable to open file!"
end

puts members.to_yaml



=begin
  :clear_raw
  :empty?
  :attributes
  :to_plain_text
  :pathname
  :output
  :attributes_as_html
  :inspect_tree
  :pretty_print_stag
  :traverse_all_element
  :traverse_some_element
  :has_attribute?
  :get_attribute
  :set_attribute
  :[]=
  :remove_attribute
  :containers
  :next_sibling
  :previous_sibling
  :preceding_siblings
  :following_siblings
  :siblings_at
  :replace_child
  :insert_before
  :insert_after
  :each_child
  :each_child_with_index
  :find_element
  :classes
  :get_element_by_id
  :get_elements_by_tag_name
  :each_hyperlink_uri
  :each_hyperlink
  :each_uri
  :traverse_text_internal
  :filter
  :"filter[]"
  :"filter[#]"
  :"filter[.]"
  :"filter[:lt]"
  :"filter[:gt]"
  :"filter[:nth]"
  :"filter[:eq]"
  :"filter[:nth-of-type]"
  :"filter[:first]"
  :"filter[:first-of-type]"
  :"filter[:last]"
  :"filter[:last-of-type]"
  :"filter[:even]"
  :"filter[:odd]"
  :"filter[:first-child]"
  :"filter[:nth-child]"
  :"filter[:last-child]"
  :"filter[:nth-last-child]"
  :"filter[:nth-last-of-type]"
  :"filter[:only-of-type]"
  :"filter[:only-child]"
  :"filter[:parent]"
  :"filter[:empty]"
  :"filter[:root]"
  :"filter[text]"
  :"filter[comment]"
  :"filter[:contains]"
  :"filter[text()=]"
  :"filter[text()!=]"
  :"filter[text()~=]"
  :"filter[text()|=]"
  :"filter[text()^=]"
  :"filter[text()$=]"
  :"filter[text()*=]"
  :"filter[@=]"
  :"filter[@!=]"
  :"filter[@~=]"
  :"filter[@|=]"
  :"filter[@^=]"
  :"filter[@$=]"
  :"filter[@*=]"
  :"filter[text()]"
  :"filter[@]"
  :"filter[[]"
  :doc?
  :elem?
  :text?
  :xmldecl?
  :doctype?
  :procins?
  :comment?
  :bogusetag?
  :make
  :to_html
  :to_original_html
  :index
  :nodes_at
  :next_node
  :previous
  :previous_node
  :preceding
  :following
  :after
  :before
  :swap
  :get_subnode
  :inner_text
  :innerText
  :html
  :inner_html
  :innerHTML
  :inner_html=
  :innerHTML=
  :clean_path
  :xpath
  :css_path
  :node_position
  :position
  :search
  :at
  :traverse_element
  :children_of_type
  :traverse_text
  :html_quote
  :if_output
  :altered!
  :name
  :name=
  :parent
  :parent=
  :raw_attributes
  :raw_attributes=
  :etag
  :etag=
  :raw_string
  :raw_string=
  :allowed
  :allowed=
  :tagno
  :tagno=
  :children
  :children=

=end