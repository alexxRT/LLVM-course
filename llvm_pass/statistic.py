import matplotlib.pylab as plt
import sys

MAX_WIN_SIZE = 5

def get_win_name(win: list):
    return "<-".join(win)

def read_window(instr_list: list, start_indx: int, win_size):
    window = []

    if start_indx + win_size >= len(trace_rec):
        print("Unable to read win. Lack of records")
        return None, -1

    for i in instr_list[start_indx:start_indx + win_size]:
        window.append(i)

    return window, start_indx + win_size

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Please provide window size for analizies: python3 statistic.py win_size")
        exit(-1)
    
    win_size = int(sys.argv[1])
    if (win_size > MAX_WIN_SIZE):
        print(f"Window maximum size is {MAX_WIN_SIZE}")
        exit(-1)

    trace_rec = []
    with open("trace.txt", "r") as trace:
        trace_rec = [line.strip("\n") for line in trace.readlines()]
    
    if not trace_rec: 
        print(f"No trace records to present build statistic")
        exit(-1)

    stat = {}
    for indx, trace in enumerate(trace_rec):
        window, end_indx = read_window(trace_rec, indx, win_size)
        if window is None:
            break

        win_name = get_win_name(window)
        if not stat.get(win_name, False):
            stat[win_name] = 1
        else:
            stat[win_name] += 1

    stat = {k: v for k, v in stat.items() if v != 0}

    figure  = plt.figure(figsize=(15, 7))

    y = [int(y) for y in stat.values()]
    x = [str(x) for x in stat.keys()]

    bars = plt.bar(stat.keys(), stat.values())

    for i in range(len(x)):
        plt.text(i, 2 * y[i] // 3, f"{y[i]}", ha="center", rotation=90)

    plt.grid(None, "both", "y")

    plt.title("Call's trace statistic")
    plt.xticks(rotation=45, fontsize=5)

    plt.show()