require_relative '../config/environment'
require 'pry'
ActiveRecord::Base.logger = nil
PROMPT = TTY::Prompt.new

#OPENING_MENU = back_to_opening
user_input =  ""
######## PROMPTS #########################

def user_prompt_one
    user_selection_parks = PROMPT.select("Explore the parks:", Park.names_by_alpha)
    puts Park.find_by(name: user_selection_parks).list_display
    puts "Press enter to return to the main menu"
    gets.chomp
    "main"
end

def user_prompt_two
    user_selection_tags = PROMPT.select("View the tags:",Tag.names)
    park_names = TagAssignment.find_park_by_tag(user_selection_tags) 
    puts park_names 
    puts "\n"
    puts "Press enter to return to the main menu"
    gets.chomp
    "main"
end

def user_prompt_three
    user_find_or_create_tags = PROMPT.ask("View and/or create tags", default: ENV["User"])
    find_create_tags = Tag.find_or_create_by(name: user_find_or_create_tags)
    puts "#{user_find_or_create_tags} has been successfully added!"
    puts "\n"
    puts "Press enter to return to the main menu"
    gets.chomp
    "main"
end

def user_prompt_four
    user_delete_tag = PROMPT.select("Choose the tag you'd like to delete", Tag.names)
    delete_tags = Tag.delete_tag(user_delete_tag)
    puts "#{user_delete_tag} has been successfully removed!"
    puts "\n"
    puts "Press enter to return to the main menu"
    gets.chomp
    "main"
end

def user_prompt_five
    user_selection_parks = PROMPT.select("Choose a park to tag:", Park.names_by_alpha)
    user_selection_tags = PROMPT.select("Choose a tag to assign:", Tag.names)
    tag_park = TagAssignment.find_or_create_by(park: Park.find_by(name: user_selection_parks), tag: Tag.find_by(name: user_selection_tags))
    puts "#{user_selection_parks} has been updated with the #{user_selection_tags} tag!"
    puts "\n"
    puts "Press enter to return to the main menu"
    gets.chomp
    "main"
end

def main_menu
    PROMPT.select("Please select from the options below:", ["1. Explore the parks", "2. View tags", "3. Find or create tags", "4. Delete tags", "5. Tag a park", "6. Exit"])
end

######################################
user_input = ""
puts `clear`
########## METHOD AREA ##########
user_input = "main"
#################################

class Interface
    font = TTY::Font.new(:standard)
    pastel = Pastel.new
    puts pastel.green.bold(font.write("MyParks"))
    puts pastel.blue.bold(font.write("Tagger"))
end

puts "\n"

def greeting
    puts "Welcome to MyParks Tagger!"
    puts "\n"
end
greeting
puts "Press press enter to get started!"

gets.chomp 
puts "Loading park data..."
sleep(2)

while user_input != "6. Exit"
    case user_input
    when "main"
        puts `clear`
        user_input = main_menu
    when "1. Explore the parks"
        puts `clear`
        user_input = user_prompt_one
    when "2. View tags"
        puts `clear`
        user_input = user_prompt_two
    when "3. Find or create tags"
        puts `clear`
        user_input = user_prompt_three
    when "4. Delete tags"
        puts `clear`
        user_input = user_prompt_four
    when "5. Tag a park"
        puts `clear`
        user_input = user_prompt_five
    end
end