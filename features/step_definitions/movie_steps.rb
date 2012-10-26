# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    m = Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.body.index(e1) < page.body.index(e2)
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each do | rating |
    rating = "ratings_" + rating
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
  end
  #list=rating_list.split(',')
  #list.each do |it|
   # it= "ratings_" + it 
    #if uncheck
     # uncheck(it)
    # check(it)
    #end
  #end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should (not )?see movies rated: (.*)/ do |negation, rating_list|
  ratings = rating_list.split(",")
  ratings = Movie.all_ratings - ratings if negation
  db_size = filtered_movies = Movie.find(:all, :conditions => {:rating => ratings}).size
  page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{db_size} ]")
end

#Then /I should (not )?see movies rated: (.*)/ do |n, rating_list|
  #list=rating_list.split(',')
  #if n
   # list=["G","PG","PG-13","NC-17","R"]-list
    #Movie.all_ratings-list
  #end
  #Movie.find(:all, :conditions => {:rating => list}).each do |mov|
   #   page.body.to_s.include?(mov["title"])
  #end
  #rows = page.all('table#movies tr').count
  #if n
   # if rows != 6
    #  assert true
    #end
  #else
   # if rows == 6
    #  assert true
    #end
  #end
  #(Movie.find(:all, :conditions => {:rating => list}).size)-1
  #db_size = Movie.find(:all, :conditions => {:rating => list}).size
  #page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{db_size} ]")
#end

#Then /^I should (not )?see all of the movies:$/ do |neg|
 # Movie.all.each do |movie|
  #  step %Q{I should #{neg}see "#{movie[:title]}"}
  #end
  #rows = Movie.all.count
  #if neg.nil?
   # if page.respond_to? :should
    #  page.should have_css("table#movies tbody>tr", :count => rows)
    #else
     # assert page.has_css?("table#movies tbody>tr", :count => rows), "#{page.all("table#movies tbody>tr").count} #{rows}"
    #end
  #end
#end

#Then /I should( not)? see all of the movies/ do |orNot|
  
 # Movie.all.each_with_index {
  #  |movie, index|
   #   name = movie[:title]
    #  if(!index) #first element
     #   step %Q{I should#{orNot} see "#{name}"}
      #else
       # step %Q{I should#{orNot} see "#{name}"}
      #end
  #}
Then /^I should see (all|none) of the movies$/ do |type|
  if type=="none"
    rows = (page.all("#movies tr").count)-1
    page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{rows} ]")

  elsif type=="all"
    rows = page.all('table#movies tr').count
    rows.should == 6
    #if page.all('table#movies tr').count == 10
     #assert true
    #else
     #assert "Not showing all movies"
   #end
    #rows = (Movie.all.size)/2
    #page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{rows} ]")
    #movies = Movie.all
    #assert_equal page.all('table#movies tbody tr').count, 10
    #movies.map(&:title).each do |movie|
     # step %Q{I should see "#{movie}"}
    #end
  end
    #rows = Movie.all.size
    #page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{rows} ]")
    #Movie.all.each do |mov|
     # page.body.to_s.include?(mov["title"])
    #end
  #end
    #rows = Movie.all.size if type == "all"
  #rows.should == value
  #page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{rows} ]")
  
  #rows = page.all("#movies tr").count
  #if filter =="none"
   #page.should have_css "#movies tr", :count => number_of_rows.to_i
   
   # list = @selected_ratings
    #db_size = Movie.find(:all, :conditions => {:rating => list.keys}).size
  #end
  #else
  #rows.should == value
  #if filter == "all"
    
  #end
end


When /^I (un)?check all the ratings$/ do | uncheck |
  Movie.all_ratings.each do | it  |
    it = "ratings_" + it
    if uncheck
      uncheck(it.strip)
    else
      check(it.strip)
    end
  end
end