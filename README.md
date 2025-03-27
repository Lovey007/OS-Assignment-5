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

### FCFS
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
### SJF (Non-Preemptive)
```
CPU Scheduling Algorithms Implementation
------------------------------------------
Select Scheduling Algorithm:
1. FCFS Scheduling
2. SJF Scheduling (Non-Preemptive/Preemptive)
3. Non Preemptive Priority Scheduling
4. Round Robin Scheduling
Enter your choice [1-4]: 2
Enter number of processes: 5
Enter Arrival Time for process P1: 0
Enter Burst Time for process P1: 6
Enter Priority for process P1 [lower number => higher priority]: 3
Enter Arrival Time for process P2: 2
Enter Burst Time for process P2: 2
Enter Priority for process P2 [lower number => higher priority]: 5
Enter Arrival Time for process P3: 4
Enter Burst Time for process P3: 8
Enter Priority for process P3 [lower number => higher priority]: 1
Enter Arrival Time for process P4: 6
Enter Burst Time for process P4: 3
Enter Priority for process P4 [lower number => higher priority]: 2
Enter Arrival Time for process P5: 8
Enter Burst Time for process P5: 4
Enter Priority for process P5 [lower number => higher priority]: 4
Select SJF mode (n for Non-Preemptive, p for Preemptive): n

--- SJF Non-Preemptive Scheduling ---

Process AT      BT      CT      TAT     WT
P1      0    6    6    6    0
P2      2    2    8    6    4
P3      4    8    23   19   11
P4      6    3    11   5    2
P5      8    4    15   7    3

Average Waiting Time: 4.00
Average Turnaround Time: 8.60

Gantt Chart:
 --- --- --- --- ---
| P1| P2| P4| P5| P3|
 --- --- --- --- ---
0      6   6   8   8  11  11  15  15  23

Execution completed. The terminal will remain active.
Press Ctrl+C to terminate the script.
```
### SJF (Preemptive)
```
CPU Scheduling Algorithms Implementation
------------------------------------------
Select Scheduling Algorithm:
1. FCFS Scheduling
2. SJF Scheduling (Non-Preemptive/Preemptive)
3. Non Preemptive Priority Scheduling
4. Round Robin Scheduling
Enter your choice [1-4]: 2
Enter number of processes: 5
Enter Arrival Time for process P1: 0
Enter Burst Time for process P1: 6
Enter Priority for process P1 [lower number => higher priority]: 3
Enter Arrival Time for process P2: 2
Enter Burst Time for process P2: 2
Enter Priority for process P2 [lower number => higher priority]: 5
Enter Arrival Time for process P3: 4
Enter Burst Time for process P3: 8
Enter Priority for process P3 [lower number => higher priority]: 1
Enter Arrival Time for process P4: 6
Enter Burst Time for process P4: 3
Enter Priority for process P4 [lower number => higher priority]: 2
Enter Arrival Time for process P5: 8
Enter Burst Time for process P5: 4
Enter Priority for process P5 [lower number => higher priority]: 4
Select SJF mode (n for Non-Preemptive, p for Preemptive): p

--- SJF Preemptive Scheduling ---

Process AT      BT      CT      TAT     WT
P1      0    6    8    8    2
P2      2    2    4    2    0
P3      4    8    23   19   11
P4      6    3    11   5    2
P5      8    4    15   7    3

Average Waiting Time: 3.60
Average Turnaround Time: 8.20

Gantt Chart:
 --- --- --- --- --- ---
| P1| P2| P1| P4| P5| P3|
 --- --- --- --- --- ---
0      0   2   4   8  11  15  23

Execution completed. The terminal will remain active.
Press Ctrl+C to terminate the script.
```
### NPPS
```
CPU Scheduling Algorithms Implementation
------------------------------------------
Select Scheduling Algorithm:
1. FCFS Scheduling
2. SJF Scheduling (Non-Preemptive/Preemptive)
3. Non Preemptive Priority Scheduling
4. Round Robin Scheduling
Enter your choice [1-4]: 3
Enter number of processes: 5
Enter Arrival Time for process P1: 0
Enter Burst Time for process P1: 4
Enter Priority for process P1 [lower number => higher priority]: 3
Enter Arrival Time for process P2: 1
Enter Burst Time for process P2: 3
Enter Priority for process P2 [lower number => higher priority]: 5
Enter Arrival Time for process P3: 2
Enter Burst Time for process P3: 1
Enter Priority for process P3 [lower number => higher priority]: 1
Enter Arrival Time for process P4: 3
Enter Burst Time for process P4: 2
Enter Priority for process P4 [lower number => higher priority]: 2
Enter Arrival Time for process P5: 4
Enter Burst Time for process P5: 3
Enter Priority for process P5 [lower number => higher priority]: 4

--- Non Preemptive Priority Scheduling ---

Process AT      BT      CT      TAT     WT
P1      0    4    4    4    0
P2      1    3    13   12   9
P3      2    1    5    3    2
P4      3    2    7    4    2
P5      4    3    10   6    3

Average Waiting Time: 3.20
Average Turnaround Time: 5.80

Gantt Chart:
 --- --- --- --- ---
| P1| P3| P4| P5| P2|
 --- --- --- --- ---
0      4   4   5   5   7   7  10  10  13

Execution completed. The terminal will remain active.
Press Ctrl+C to terminate the script.
```
### Round Robin
```
CPU Scheduling Algorithms Implementation
------------------------------------------
Select Scheduling Algorithm:
1. FCFS Scheduling
2. SJF Scheduling (Non-Preemptive/Preemptive)
3. Non Preemptive Priority Scheduling
4. Round Robin Scheduling
Enter your choice [1-4]: 4
Enter number of processes: 5
Enter Arrival Time for process P1: 0
Enter Burst Time for process P1: 6
Enter Priority for process P1 [lower number => higher priority]: 3
Enter Arrival Time for process P2: 1
Enter Burst Time for process P2: 4
Enter Priority for process P2 [lower number => higher priority]: 5
Enter Arrival Time for process P3: 2
Enter Burst Time for process P3: 5
Enter Priority for process P3 [lower number => higher priority]: 1
Enter Arrival Time for process P4: 3
Enter Burst Time for process P4: 3
Enter Priority for process P4 [lower number => higher priority]: 2
Enter Arrival Time for process P5: 4
Enter Burst Time for process P5: 7
Enter Priority for process P5 [lower number => higher priority]: 4
Enter Time Quantum: 2

--- Round Robin Scheduling (Quantum = 2) ---

Process AT      BT      CT      TAT     WT
P1      0    6    21   21   15
P2      1    4    14   13   9
P3      2    5    22   20   15
P4      3    3    17   14   11
P5      4    7    25   21   14

Average Waiting Time: 12.80
Average Turnaround Time: 17.80

Gantt Chart:
 --- --- --- --- --- --- --- --- --- --- --- --- --- ---
| P1| P2| P3| P4| P5| P1| P2| P3| P4| P5| P1| P3| P5| P5|
 --- --- --- --- --- --- --- --- --- --- --- --- --- ---
0      2   4   6   8  10  12  14  16  17  19  21  22  24  25

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



