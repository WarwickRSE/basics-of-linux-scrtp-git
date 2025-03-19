from pathlib import Path
import random
import lorem

pong_file = Path("/pong_game/")
team_1_file = Path("/pong_game/team1")
team_2_file = Path("/pong_game/team2")


# do this a random number of times

for _ in range(random.randint(1, 20)):
    with open(pong_file / "truth.txt", "a") as truth_file:
        # generate a random number between 1 and a 1000000
        truth = random.randint(1, 1000000)

        if truth % 2 == 0:
            team_file = team_1_file
        else:
            team_file = team_2_file
        with open(team_file / f"{truth}.txt", "w") as f:
            # fill the file with junk data and within it a line with the points
            junk_text = lorem.get_paragraph()
            # generate a random number of points between -10 and 10
            points = random.randint(-10, 10)
            point_text = f" This file scores {points} points "
            # insert the point_text randomly in the junk_text
            insert_point = random.randint(0, len(junk_text))
            f.write(junk_text[:insert_point] + point_text + junk_text[insert_point:])

        truth_file.write(f"{str(truth)}, {str(points)}")
