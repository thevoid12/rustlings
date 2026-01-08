#!/usr/bin/env bash

if [ ! -f ".rustlings-state.txt" ]; then
    echo "Error: .rustlings-state.txt not found in current directory"
    exit 1
fi

if [ ! -f ".gitignore" ]; then
    echo "Error: .gitignore not found in current directory"
    exit 1
fi

STATE_FILE=".rustlings-state.txt"

# Start with base .gitignore
cat > .gitignore << 'EOF'
Cargo.lock
target/
.vscode/
EOF

COMPLETED=$(tail -n +4 "$STATE_FILE")

# Enable recursive globbing for **
shopt -s globstar


# Track directories with incomplete exercises
declare -A incomplete_dirs

# Process exercises
if [ -d "exercises" ]; then
    for exercise_file in exercises/**/*.rs; do
        exercise_name=$(basename "$exercise_file" .rs)
        exercise_dir=$(dirname "$exercise_file")

        # Check if this exercise is NOT in the completed list
        if ! echo "$COMPLETED" | grep -q "^${exercise_name}$"; then
            echo "$exercise_file" >> .gitignore
            incomplete_dirs["$exercise_dir"]=1
        fi
    done

    # Add README.md files from directories with incomplete exercises
    for dir in "${!incomplete_dirs[@]}"; do
        if [ -f "$dir/README.md" ]; then
            echo "$dir/README.md" >> .gitignore
        fi
    done
fi

# Process solutions - ignore solutions for incomplete exercises
if [ -d "solutions" ]; then
    for solution_file in solutions/**/*.rs; do
        solution_name=$(basename "$solution_file" .rs)
        solution_dir=$(dirname "$solution_file")

        # Check if this solution's exercise is NOT completed
        if ! echo "$COMPLETED" | grep -q "^${solution_name}$"; then
            echo "$solution_file" >> .gitignore
        fi
    done

    # Add README.md files from solution directories with incomplete exercises
    for dir in "${!incomplete_dirs[@]}"; do
        # Convert exercises path to solutions path
        solution_dir="${dir/exercises/solutions}"
        if [ -f "$solution_dir/README.md" ]; then
            echo "$solution_dir/README.md" >> .gitignore
        fi
    done
fi

echo "Updated .gitignore based on completed exercises in $STATE_FILE"
echo ""
echo "Completed exercises (will be committable):"
echo "$COMPLETED"
echo ""
echo "Incomplete exercises (ignored) count: $(grep -c "exercises/" .gitignore || echo 0)"
