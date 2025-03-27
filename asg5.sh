
#!/bin/bash
# cpu_scheduling.sh


#############################
##  NAME: PRANZAL SHARMA   ##
##     SID: 21105048       ##
##      BRANCH: ECE        ##
##     ASSIGNMENT- 5       ##
#############################


# Utility Functions
     
function print_table() {
    local n=$1
    echo -e "\nProcess\tAT\tBT\tCT\tTAT\tWT"
    for (( i=0; i<n; i++ )); do
        printf "P%-7s%-5d%-5d%-5d%-5d%-5d\n" "${pids[i]}" "${arrival[i]}" "${burst[i]}" "${CT[i]}" "${TAT[i]}" "${WT[i]}"
    done
}

function print_metrics() {
    echo -e "\nAverage Waiting Time: $avgWT"
    echo "Average Turnaround Time: $avgTAT"
}

function print_gantt_chart() {
    echo -e "\nGantt Chart:"
    # Print top border
    for segment in "${gantt[@]}"; do
        printf " ---"
    done
    echo ""
    # Print process segments
    for segment in "${gantt[@]}"; do
        printf "|%3s" "$segment"
    done
    echo "|"
    # Print bottom border
    for segment in "${gantt[@]}"; do
        printf " ---"
    done
    echo ""
    # Print timeline marks
    for (( i=0; i<${#time_marks[@]}; i++ )); do
        if [ $i -eq 0 ]; then
            printf "%-4s" "${time_marks[i]}"
        else
            printf "%4s" "${time_marks[i]}"
        fi
    done
    echo ""
}


# Scheduling Algorithms


# 1. FCFS Scheduling

function fcfs() {
    n=$1
    # sort indices by arrival time
    local sorted=($(seq 0 $((n-1))))
    for ((i = 0; i < n; i++)); do
        for ((j = i+1; j < n; j++)); do
            if [ "${arrival[${sorted[i]}]}" -gt "${arrival[${sorted[j]}]}" ]; then
                temp=${sorted[i]}
                sorted[i]=${sorted[j]}
                sorted[j]=$temp
            fi
        done
    done

    current_time=0
    unset CT TAT WT
    declare -a CT TAT WT
    unset gantt time_marks
    declare -a gantt time_marks
    time_marks=()

    # FCFS simulation
    for idx in "${sorted[@]}"; do
        # Idle if process not yet arrived
        if [ $current_time -lt ${arrival[$idx]} ]; then
            gantt+=("IDLE")
            time_marks+=("$current_time")
            current_time=${arrival[$idx]}
        fi
        time_marks+=("$current_time")
        gantt+=("P$((idx+1))")
        current_time=$(( current_time + burst[$idx] ))
        CT[$idx]=$current_time
        TAT[$idx]=$(( CT[$idx] - arrival[$idx] ))
        WT[$idx]=$(( TAT[$idx] - burst[$idx] ))
        time_marks+=("$current_time")
    done

    # Calculate averages using awk for floating point division
    sumWT=0
    sumTAT=0
    for (( i=0; i<n; i++ )); do
        sumWT=$(( sumWT + WT[i] ))
        sumTAT=$(( sumTAT + TAT[i] ))
    done
    avgWT=$(awk -v sum="$sumWT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')
    avgTAT=$(awk -v sum="$sumTAT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')

    echo -e "\n--- FCFS Scheduling ---"
    print_table $n
    print_metrics
    print_gantt_chart
}

# 2. SJF Scheduling

# Option for Non-Preemptive and Preemptive modes.
function sjf_scheduling() {
    n=$1
    read -p "Select SJF mode (n for Non-Preemptive, p for Preemptive): " mode
    if [ "$mode" = "n" ]; then
        sjf_nonpreemptive $n
    elif [ "$mode" = "p" ]; then
        sjf_preemptive $n
    else
        echo "Invalid mode selected for SJF."
    fi
}

# 2a. SJF Non-Preemptive Scheduling
function sjf_nonpreemptive() {
    n=$1
    local completed=0
    current_time=0
    unset CT TAT WT
    declare -a CT TAT WT
    declare -a done
    for (( i=0; i<n; i++ )); do
        done[i]=0
    done

    unset gantt time_marks
    declare -a gantt time_marks
    time_marks=()

    while [ $completed -lt $n ]; do
        min_bt=99999
        idx=-1
        for (( i=0; i<n; i++ )); do
            if [ ${arrival[i]} -le $current_time ] && [ ${done[i]} -eq 0 ]; then
                if [ ${burst[i]} -lt $min_bt ]; then
                    min_bt=${burst[i]}
                    idx=$i
                fi
            fi
        done

        if [ $idx -eq -1 ]; then
            # CPU idle if no process has arrived
            if [ ${#time_marks[@]} -eq 0 ]; then
                time_marks+=("$current_time")
            fi
            gantt+=("IDLE")
            current_time=$(( current_time + 1 ))
            time_marks+=("$current_time")
        else
            if [ $current_time -lt ${arrival[$idx]} ]; then
                current_time=${arrival[$idx]}
            fi
            time_marks+=("$current_time")
            gantt+=("P$((idx+1))")
            current_time=$(( current_time + burst[$idx] ))
            time_marks+=("$current_time")
            CT[$idx]=$current_time
            TAT[$idx]=$(( CT[$idx] - arrival[$idx] ))
            WT[$idx]=$(( TAT[$idx] - burst[$idx] ))
            done[idx]=1
            completed=$((completed + 1))
        fi
    done

    sumWT=0
    sumTAT=0
    for (( i=0; i<n; i++ )); do
        sumWT=$(( sumWT + WT[i] ))
        sumTAT=$(( sumTAT + TAT[i] ))
    done
    avgWT=$(awk -v sum="$sumWT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')
    avgTAT=$(awk -v sum="$sumTAT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')

    echo -e "\n--- SJF Non-Preemptive Scheduling ---"
    print_table $n
    print_metrics
    print_gantt_chart
}

# 2b. SJF Preemptive Scheduling
function sjf_preemptive() {
    n=$1
    # Initialize remaining burst times
    declare -a rem
    for (( i=0; i<n; i++ )); do
        rem[i]=${burst[i]}
    done

    current_time=0
    completed=0
    unset CT TAT WT
    declare -a CT TAT WT

    unset gantt time_marks
    declare -a gantt time_marks
    time_marks=()
    time_marks+=("$current_time")

    prev_proc="none"
    while [ $completed -lt $n ]; do
        min_rem=99999
        idx=-1

        for (( i=0; i<n; i++ )); do
            if [ ${arrival[i]} -le $current_time ] && [ ${rem[i]} -gt 0 ]; then
                if [ ${rem[i]} -lt $min_rem ]; then
                    min_rem=${rem[i]}
                    idx=$i
                fi
            fi
        done

        if [ $idx -eq -1 ]; then
            # CPU idle if no process available
            if [ "$prev_proc" != "IDLE" ]; then
                gantt+=("IDLE")
            fi
            current_time=$(( current_time + 1 ))
            time_marks+=("$current_time")
            prev_proc="IDLE"
            continue
        fi

        proc_label="P$((idx+1))"
        if [ "$prev_proc" != "$proc_label" ]; then
            gantt+=("$proc_label")
            time_marks+=("$current_time")
            prev_proc="$proc_label"
        fi

        # Execute for 1 unit time
        rem[idx]=$(( rem[idx] - 1 ))
        current_time=$(( current_time + 1 ))

        if [ ${rem[idx]} -eq 0 ]; then
            CT[$idx]=$current_time
            TAT[$idx]=$(( CT[$idx] - arrival[idx] ))
            WT[$idx]=$(( TAT[$idx] - burst[idx] ))
            completed=$((completed + 1))
        fi
    done
    time_marks+=("$current_time")

    sumWT=0
    sumTAT=0
    for (( i=0; i<n; i++ )); do
        sumWT=$(( sumWT + WT[i] ))
        sumTAT=$(( sumTAT + TAT[i] ))
    done
    avgWT=$(awk -v sum="$sumWT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')
    avgTAT=$(awk -v sum="$sumTAT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')

    echo -e "\n--- SJF Preemptive Scheduling ---"
    print_table $n
    print_metrics
    print_gantt_chart
}

# 3. Non Preemptive Priority Scheduling (lower number = higher priority)

function priority_np() {
    n=$1
    local completed=0
    current_time=0
    unset CT TAT WT
    declare -a CT TAT WT
    declare -a done
    for (( i=0; i<n; i++ )); do
        done[i]=0
    done

    unset gantt time_marks
    declare -a gantt time_marks
    time_marks=()

    while [ $completed -lt $n ]; do
        min_prio=99999
        idx=-1
        for (( i=0; i<n; i++ )); do
            if [ ${arrival[i]} -le $current_time ] && [ ${done[i]} -eq 0 ]; then
                if [ ${priority[i]} -lt $min_prio ]; then
                    min_prio=${priority[i]}
                    idx=$i
                fi
            fi
        done

        if [ $idx -eq -1 ]; then
            if [ ${#time_marks[@]} -eq 0 ]; then
                time_marks+=("$current_time")
            fi
            gantt+=("IDLE")
            current_time=$(( current_time + 1 ))
            time_marks+=("$current_time")
        else
            if [ $current_time -lt ${arrival[$idx]} ]; then
                current_time=${arrival[$idx]}
            fi
            time_marks+=("$current_time")
            gantt+=("P$((idx+1))")
            current_time=$(( current_time + burst[$idx] ))
            time_marks+=("$current_time")
            CT[$idx]=$current_time
            TAT[$idx]=$(( CT[$idx] - arrival[$idx] ))
            WT[$idx]=$(( TAT[$idx] - burst[$idx] ))
            done[idx]=1
            completed=$((completed + 1))
        fi
    done

    sumWT=0
    sumTAT=0
    for (( i=0; i<n; i++ )); do
        sumWT=$(( sumWT + WT[i] ))
        sumTAT=$(( sumTAT + TAT[i] ))
    done
    avgWT=$(awk -v sum="$sumWT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')
    avgTAT=$(awk -v sum="$sumTAT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')

    echo -e "\n--- Non Preemptive Priority Scheduling ---"
    print_table $n
    print_metrics
    print_gantt_chart
}

# 4. Round Robin Scheduling

function round_robin() {
    n=$1
    quantum=$2
    declare -a rem
    for (( i=0; i<n; i++ )); do
        rem[i]=${burst[i]}
    done

    current_time=0
    completed=0
    unset CT TAT WT
    declare -a CT TAT WT
    for (( i=0; i<n; i++ )); do
        CT[i]=0
    done

    unset gantt time_marks
    declare -a gantt time_marks
    time_marks=()
    time_marks+=("$current_time")

    while [ $completed -lt $n ]; do
        cycle_done=1
        for (( i=0; i<n; i++ )); do
            if [ ${arrival[i]} -le $current_time ] && [ ${rem[i]} -gt 0 ]; then
                cycle_done=0
                if [ ${rem[i]} -gt $quantum ]; then
                    gantt+=("P$((i+1))")
                    current_time=$(( current_time + quantum ))
                    rem[i]=$(( rem[i] - quantum ))
                    time_marks+=("$current_time")
                else
                    gantt+=("P$((i+1))")
                    current_time=$(( current_time + rem[i] ))
                    rem[i]=0
                    CT[i]=$current_time
                    time_marks+=("$current_time")
                    completed=$(( completed + 1 ))
                fi
            fi
        done
        if [ $cycle_done -eq 1 ]; then
            gantt+=("IDLE")
            current_time=$(( current_time + 1 ))
            time_marks+=("$current_time")
        fi
    done

    for (( i=0; i<n; i++ )); do
        TAT[i]=$(( CT[i] - arrival[i] ))
        WT[i]=$(( TAT[i] - burst[i] ))
    done
    sumWT=0
    sumTAT=0
    for (( i=0; i<n; i++ )); do
        sumWT=$(( sumWT + WT[i] ))
        sumTAT=$(( sumTAT + TAT[i] ))
    done
    avgWT=$(awk -v sum="$sumWT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')
    avgTAT=$(awk -v sum="$sumTAT" -v n="$n" 'BEGIN {printf "%.2f", sum/n}')

    echo -e "\n--- Round Robin Scheduling (Quantum = $quantum) ---"
    print_table $n
    print_metrics
    print_gantt_chart
}


# Main Program

echo "CPU Scheduling Algorithms Implementation"
echo "------------------------------------------"
echo "Select Scheduling Algorithm:"
echo "1. FCFS Scheduling"
echo "2. SJF Scheduling (Non-Preemptive/Preemptive)"
echo "3. Non Preemptive Priority Scheduling"
echo "4. Round Robin Scheduling"
read -p "Enter your choice [1-4]: " choice

# Get number of processes
read -p "Enter number of processes: " nproc

# Initialize arrays to hold process information
declare -a pids arrival burst priority
for (( i=0; i<nproc; i++ )); do
    pids[i]=$(( i+1 ))
    read -p "Enter Arrival Time for process P$((i+1)): " at
    arrival[i]=$at
    read -p "Enter Burst Time for process P$((i+1)): " bt
    burst[i]=$bt
    read -p "Enter Priority for process P$((i+1)) [lower number => higher priority]: " pr
    priority[i]=$pr
done

# For Round Robin, get the time quantum
if [ "$choice" -eq 4 ]; then
    read -p "Enter Time Quantum: " quantum
fi

case $choice in
    1)
        fcfs $nproc
        ;;
    2)
        sjf_scheduling $nproc
        ;;
    3)
        priority_np $nproc
        ;;
    4)
        round_robin $nproc $quantum
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac

echo -e "\nExecution completed. The terminal will remain active."
echo "Press Ctrl+C to terminate the script."
# Keep the terminal open until manual kill
while true; do
    sleep 5
done
