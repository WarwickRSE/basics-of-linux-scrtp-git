from pathlib import Path
import re

#if running in docker
pong_file = Path("/pong_game/")
team_1_file = Path("/pong_game/team1/")
team_2_file = Path("/pong_game/team2/")
# else running locally
# pong_file = Path("./")
# team_1_file = Path("team1/")
# team_2_file = Path("team2/")


def check_cheat(score, file_path):
    with open(pong_file / "truth.txt", "r") as truth_file:
        file_num = str(file_path).strip(".txt")
        check_str = file_num + ", " + str(score)
        truth = truth_file.read()
        if check_str in truth:
            return True
        else:
            return False


def find_score(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
        match = re.search(r'This file scores (-?\d+) points', content)
        if match:
            score = int(match.group(1))
            if check_cheat(score, file_path):
                return 0
            else:
                return score
        else:
            return 0


if __name__ == "__main__":
    team_1_score = 0
    for file in team_1_file.iterdir():
        team_1_score += find_score(file)

    team_2_score = 0
    for file in team_2_file.iterdir():
        team_2_score += find_score(file)
    
    print(f"Team 1: {team_1_score}")
    print(f"Team 2: {team_2_score}")

