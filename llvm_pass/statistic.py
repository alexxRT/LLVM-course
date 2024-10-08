import matplotlib.pylab as plt


if __name__ == "__main__":
    module = input("Please enter module name you want statistic for: ")

    module_start_indx = 0
    module_end_indx = 0
    trace_rec = []
    # prepare trace extract one we need
    with open("trace.txt", "r") as trace:
        modules_trace = trace.readlines()
        for line in modules_trace:
            if module in line:
                module_start_indx = modules_trace.index(line) + 1
                break
        for line_indx, line in enumerate(modules_trace[module_start_indx:]):
            if "<-" not in line:
                module_end_indx = line_indx
                break
    
    trace_rec = [trace.strip("\n") for trace in modules_trace[module_start_indx:module_end_indx]]
    print(f"Module {module} has {len(trace_rec)} lines in a record")
    
    if not trace_rec: 
        print(f"No trace records to present statistic for module {module}")
        exit(-1)

    stat = {}
    # collect statistic
    for line in trace_rec:
        if not stat.get(line, False):
            stat[line] = 1
        else:
            stat[line] += 1

    figure  = plt.figure(figsize=(10, 7))

    y = [int(y) for y in stat.values()]
    x = [str(x) for x in stat.keys()]

    bars = plt.bar(stat.keys(), stat.values())

    for i in range(len(x)):
        plt.text(i, y[i] // 2, f"{y[i]}", ha="center")

    plt.grid(None, "both", "y")

    plt.title("Call's trace statistic")
    plt.xticks(rotation=45, fontsize=5)

    plt.show()