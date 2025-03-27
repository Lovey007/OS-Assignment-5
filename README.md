# CPU Scheduling Script

## Overview
This Bash script implements various CPU scheduling algorithms, allowing users to enter process details and view the scheduling results, including a Gantt chart, completion times, and average waiting and turnaround times.

## Features
- First Come First Serve (FCFS) Scheduling
- Shortest Job First (SJF) Scheduling (Non-Preemptive & Preemptive)
- Non-Preemptive Priority Scheduling
- Round Robin Scheduling
- Displays Gantt Chart
- Calculates Average Waiting Time & Turnaround Time

## Usage
### Running the Script
Ensure the script has execute permissions:
```bash
chmod +x cpu_scheduling.sh
./cpu_scheduling.sh
```

### User Input
1. Select the scheduling algorithm from the menu.
2. Enter the number of processes.
3. Provide the following details for each process:
   - Arrival Time (AT)
   - Burst Time (BT)
   - Priority (for Priority Scheduling, lower number = higher priority)
4. If using Round Robin, specify the Time Quantum.

### Output
- The script will display the computed scheduling order.
- It will print the Gantt chart representing the process execution timeline.
- Key metrics such as Completion Time (CT), Turnaround Time (TAT), and Waiting Time (WT) will be displayed.
- The average Waiting Time and Turnaround Time will also be calculated.

## Dependencies
- The script requires `awk` for floating-point calculations.
- Works on any Linux/Unix-based system with Bash support.

## Example Execution
```
CPU Scheduling Algorithms Implementation
------------------------------------------
Select Scheduling Algorithm:
1. FCFS Scheduling
2. SJF Scheduling (Non-Preemptive/Preemptive)
3. Non Preemptive Priority Scheduling
4. Round Robin Scheduling
Enter your choice [1-4]: 1
Enter number of processes: 3
Enter Arrival Time for process P1: 0
Enter Burst Time for process P1: 3
Enter Priority for process P1 [lower number => higher priority]: 1
Enter Arrival Time for process P2: 1
Enter Burst Time for process P2: 1
Enter Priority for process P2 [lower number => higher priority]: 3
Enter Arrival Time for process P3: 0
Enter Burst Time for process P3: 1
Enter Priority for process P3 [lower number => higher priority]: 2

--- FCFS Scheduling ---

Process AT      BT      CT      TAT     WT
P1      0    3    3    3    0
P2      1    1    5    4    3
P3      0    1    4    4    3

Average Waiting Time: 2.00
Average Turnaround Time: 3.67

Gantt Chart:
 --- --- ---
| P1| P3| P2|
 --- --- ---
0      3   3   4   4   5

Execution completed. The terminal will remain active.
Press Ctrl+C to terminate the script.
```

## Notes
- The script continues running after execution. Press `Ctrl+C` to terminate it.
- If an invalid choice is made, the script will exit with an error message.

## Author
- Name: Pranzal Sharma
- SID: 21105048
- Branch: ECE
- Assignment: 5



