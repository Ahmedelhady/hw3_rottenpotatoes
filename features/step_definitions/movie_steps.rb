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
  list=rating_list.split(',')
  list.each do |it|
    it= "ratings_" + it 
    if uncheck
      uncheck(it.strip)
    else
      check(it.strip)
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should (not )?see movies rated: (.*)/ do |n, rating_list|
  list=rating_list.split(',')
  if n
    list=Movie.all_ratings-list
  end
  db_size = Movie.find(:all, :conditions => {:rating => list}).size
  page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{db_size} ]")
end

Then /^I should see (all|none|) of the movies$/ do |type|
  rows = (page.all("#movies tr").count)-1
  
  rows = Movie.all.size if type == "all"
  #rows.should == value
  page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{rows} ]")
  
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