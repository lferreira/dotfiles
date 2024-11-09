#!/bin/bash

# Find test-related tasks in the Makefile
tasks=$(grep -E '^[a-zA-Z_-]*test[a-zA-Z_-]*:' Makefile | awk -F ':' '{print $1}' | sort)

# Check if any tasks were found
if [ -z "$tasks" ]; then
  echo "No test-related tasks found in the Makefile."
  exit 1
fi

# Convert tasks to an array for selection
task_array=($tasks)

# Display a prompt with numbered task options
echo "Select a test task to run:"
for i in "${!task_array[@]}"; do
  echo "$((i + 1)). ${task_array[i]}"
done

# Read user selection
read -p "Enter the number of the task you want to run: " selection

# Validate input and execute selected task
if [[ $selection -gt 0 && $selection -le ${#task_array[@]} ]]; then
  selected_task=${task_array[$((selection - 1))]}
  echo "Running 'make $selected_task'..."
  make "$selected_task"
else
  echo "Invalid selection. Exiting."
  exit 1
fi
