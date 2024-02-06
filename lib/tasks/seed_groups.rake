namespace :db do
  desc "Create groups and associated friends for testing"
  task seed_groups: :environment do
    # Define the group data
    group_data = [
      { group_name: 'Group 1', friends: [{name: 'Adam', color: 'blue'}, {name: 'Brian', color: 'red'}, {name: 'Charlie', color: 'orange'}, {name: 'Dave', color: 'black'}] },
      { group_name: 'Group 2', friends: [{name: 'Ethan', color: 'green'}, {name: 'Fred', color: 'yellow'}, {name: 'Greg', color: 'pink'}, {name: 'Harry', color: 'aqua'}] }
    ]

    # Iterate over each group and create the group and associated friends
    group_data.each do |group_info|
      group = Group.create!(name: group_info[:group_name])
      group_info[:friends].each do |friend_info|
        Friend.create!(name: friend_info[:name], color: friend_info[:color], group: group)
      end
    end

    puts "Groups and friends created successfully!"
  end
end