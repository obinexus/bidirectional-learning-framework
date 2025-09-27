#!/bin/bash
# complete_refactor.sh - Full bidirectional learning pathway

# Right to Act enforcement
enforce_right_to_act() {
    local user_id=$1
    local target_level=$2
    local current_level=$3
    
    # Allow lateral entry with demonstrated competence
    if has_portfolio $user_id; then
        echo "RIGHT_TO_ACT: Granted via demonstration"
        return 0
    fi
    
    # Check sequential progression
    if [[ $target_level -eq $((current_level + 1)) ]]; then
        echo "RIGHT_TO_ACT: Granted via progression"
        return 0
    fi
    
    echo "RIGHT_TO_ACT: Requires validation"
    return 1
}

# Support allocation based on level and need
allocate_support() {
    local level=$1
    local sector_gap=$2
    
    case $level in
        2)
            if [[ $sector_gap == "true" ]]; then
                echo "SUPPORT: bursary + loans (NO grants at L2)"
            fi
            ;;
        3)
            echo "SUPPORT: project grants + bursary + loans"
            ;;
        4)
            echo "SUPPORT: full grants + tailored bursary + loans"
            ;;
        5)
            echo "SUPPORT: research grants + stipend"
            ;;
    esac
}

# Peer review validation with payment
peer_review_with_payment() {
    local reviewer_level=$1
    local content_level=$2
    local validation_result=$3
    
    if [[ $reviewer_level -ge 4 ]] && [[ $validation_result == "valid" ]]; then
        echo "PAYMENT: Cross-checking fee processed"
        echo "CREDENTIAL: Peer review recorded"
    fi
}

# Main execution
main() {
    echo "=== Bidirectional Learning Framework ==="
    echo "Sectors: Computing, Arts, Design Technology"
    echo "Levels: 1(GCSE) → 2(Diploma) → 3(Applied) → 4(Masters) → 5(PhD)"
    echo ""
    echo "Key Features:"
    echo "- Level 2 gaps trigger bursary/loans (not grants)"
    echo "- Level 3+ enables project grants"
    echo "- Level 4 requires proof validation"
    echo "- Verb-Noun resolution for language barriers"
    echo "- Paid peer review for cross-checking"
    echo "- Right to Act allows lateral entry"
}

main "$@"
