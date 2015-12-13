namespace :create_players do

  task build: :environment do
    puts "Adding players to the database..................!"
    players_file = File.open(Rails.root.join('lib', 'assets', 'players.txt').to_s)

    possible_bowling_types = ['NA', '', 'Fast', 'MediumFast', 'Medium', 'Slow', 'Chinaman', 'Orthodox', 'LegSpin', 'OffSpin']
    possible_batting_hands = ["RightHanded", "LeftHanded"]
    possible_bowling_hands = ["RightHanded", "LeftHanded"]


    players_file.each do |line|
      attributes = line.split(":")

      if attributes.length == 8

        first_name_key = attributes[0].rpartition(' ').last.strip
        first_name_value = attributes[1].rpartition(' ').first.strip

        last_name_key = attributes[1].rpartition(' ').last.strip
        last_name_value = attributes[2].rpartition(' ').first.strip

        bowling_type_key = attributes[2].rpartition(' ').last.strip
        bowling_type_value = attributes[3].rpartition(' ').first.strip

        batting_hand_key = attributes[3].rpartition(' ').last.strip
        batting_hand_value = attributes[4].rpartition(' ').first.strip

        bowling_hand_key = attributes[4].rpartition(' ').last.strip
        bowling_hand_value = attributes[5].rpartition(' ').first.strip

        keeper_key = attributes[5].rpartition(' ').last.strip
        keeper_value = attributes[6].rpartition(' ').first.strip

        teams_key = attributes[6].rpartition(' ').last.strip
        teams_value = attributes[7].delete!("\n")


        # puts "collected values"
        # puts "checking keys"

        if (first_name_key == "FIRST_NAME") && (last_name_key == "LAST_NAME") && (bowling_type_key == "BOWLING_TYPE") &&
          (batting_hand_key == "BATTING_HAND") && (bowling_hand_key == "BOWLING_HAND") && (keeper_key == "KEEPER") && (teams_key == "TEAMS")

          # puts "checked keys"
          # puts "checking values"

          if (!first_name_value.blank?) && (!last_name_value.blank?) && (possible_bowling_types.include?(bowling_type_value)) &&
              (possible_batting_hands.include?(batting_hand_value)) && (possible_bowling_hands.include?(bowling_hand_value)) && (!teams_value.blank?)
            # puts "checked values"

            (keeper_value == "true") ? (keeper = true) : (keeper = false)

            player = Player.create(:first_name => first_name_value, :last_name => last_name_value, :bowling_type => bowling_type_value,
                                   :batting_hand => batting_hand_value, :bowling_hand => bowling_hand_value, :keeper => keeper)

            puts "Player added Successfully.......................!"

            players_teams = teams_value.split(',')

            team_names = Team.all.collect(&:name)

            players_teams.each do |player_team|

              if team_names.include?(player_team)
                team_id = Team.find_by(name: player_team).id
                TeamPlayer.create(team_id: team_id, player_id: player.id)
              else
                player.teams.create(name: player_team)
              end
             end
          end
        end
      end
    end
  end
end


