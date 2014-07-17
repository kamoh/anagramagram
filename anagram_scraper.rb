def anagram_scraper(term)
  
  search_term = term.gsub!(" ","+")

  results_div = "body.topbar.blockquote.p:nth-child(7)"

  source_url = "http://www.wordsmith.org/anagram/anagram.cgi?anagram=#{search_term}"
  page = Nokogiri::HTML(open(source_url))

  raw_anagrams_remove_front_matter = page.css("blockquote p:nth-child(7)").text.sub(/\n.*Displaying all:\n/,"")
  raw_anagrams_remove_rear_matter = raw_anagrams_remove_front_matter.gsub(/\n\n\n*([a-zA-Z]|\S|\s)*(...)\n*/,"")
  
  raw_anagrams_array = raw_anagrams_remove_rear_matter.split("\n")





def students_scraper
    # --- studen div css selectors ----
  student_div       = "li.home-blog-post"
  name_link_css     = "div.big-comment h3 a"
  tagline_css       = "p.home-blog-post-meta"
  students_page_url = "http://ruby005.students.flatironschool.com/"


  all_students = { }
  students_index_page = Nokogiri::HTML(open(students_page_url))
  student_divs = students_index_page.css(student_div)  


  student_divs.each do |student_div|
    all_students[student_div.css(name_link_css).text] = {
      :tagline => student_div.css(tagline_css).text, 
      :link    => student_div.css(name_link_css)[0]['href']
    }
  end

  add_quote_and_school(all_students)
end

def add_quote_and_school(all_students)
  # i = 0
  all_students.each do |name, details|
    page = Nokogiri::HTML(open("http://ruby005.students.flatironschool.com/#{details[:link]}"))
    quote = page.css(".textwidget h3").text
    school = page.css(".services ul li").text
    treehouse_link = page.css(".fourth:nth-child(2) a")[0]["href"]
    treehouse_score = get_treehouse_score(treehouse_link)
    all_students[name] = details.merge( :quote => quote, :school => school, :treehouse_score => treehouse_score )
    # i += 1
    # # binding.pry if i > 20
  end
  all_students
end

def get_treehouse_score(treehouse_link) #denine korin
  # if treehouse_link == "http://teamtreehouse.com/rosiehoyem/" || treehouse_link == "http://teamtreehouse.com/korenlsliecohen" || treehouse_link == "http://teamtreehouse.com/lukedemarest"
  #   treehouse_score = 0
  # else
  # page = Nokogiri::HTML(open(treehouse_link))
  # treehouse_score = page.css(".total-points h1").text
  # end
  begin
    page = Nokogiri::HTML(open(treehouse_link))
    treehouse_score = page.css(".total-points h1").text
  rescue => e
    case e
    when OpenURI::HTTPError
      treehouse_score = "0"
    end
  end

end
